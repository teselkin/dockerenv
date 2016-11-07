#!/bin/bash
parser=$(mktemp)
parser_out=$(mktemp)
cat << 'EOF' > ${parser}
/^uid/ {
  uid = $2
  uid_name = $3
  next
}
/^gid/ {
  gid = $2
  gid_name = $3
  next
}
/^groups/ {
  for (i=2 ;i<NF ;i+=2) {
    arr[$i] = $(i+1)
  }
}
END {
  groups = ""
  for (k in arr) {
    print "groupadd --gid " k " " arr[k]
    if (k != gid) {
      if (groups == "") {
        groups = k
      } else {
        groups = groups "," k
      }
    }
  }
  print "useradd --uid " uid " --gid " gid " --groups " groups " " uid_name
  print "echo '" uid_name " ALL=(ALL) NOPASSWD:ALL' > /etc/sudoers.d/" uid_name
  print "chmod 440 /etc/sudoers.d/" uid_name
}
EOF
echo "${ID}" | tr '[:blank:]' '\n' | tr '=(),' ' ' | awk -f ${parser} > ${parser_out}
source ${parser_out}
rm ${parser}
rm ${parser_out}
