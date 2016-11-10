#!/bin/bash
set -o xtrace
parser=$(mktemp)
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
  print "gid " gid_name " " gid
  print "uid " uid_name " " uid
  for (id in arr) {
    print "group " arr[id] " " id
  }
}
EOF
echo "${ID}" | tr '[:blank:]' '\n' | tr '=(),' ' ' | awk -f ${parser} > ${parser}.out

user_name=
user_id=
group_name=
group_id=
while read key name id; do
  case ${key} in
    'uid')
      user_id=${id}
      user_name=${name}
      useradd --create-home --uid ${user_id} --gid ${group_id} ${user_name}
    ;;
    'gid')
      group_id=${id}
      group_name=${name}
      groupadd --gid ${group_id} ${group_name}
    ;;
    'group')
      if groupadd --gid ${id} ${name}; then
        usermod -a -G ${id} ${user_name}
      fi
    ;;
  esac
done < ${parser}.out

echo "${user_name} ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/${user_name}
chmod 440 /etc/sudoers.d/${user_name}

rm ${parser}
rm ${parser}.out
