#!/bin/sh 


curl --unix-socket /var/run/docker.sock http://localhost/images/json \
| jq -r '.[].RepoTags[]' \
| awk -F: '{print $1, $2}' \
| sort -u | cut -d' ' -f1 \
| while read repo; do
    tags=$(curl --unix-socket /var/run/docker.sock http://localhost/images/json \
      | jq -r ".[] | select(.RepoTags != null) | .RepoTags[] | select(startswith(\"$repo:\"))" \
      | cut -d: -f2 | sort -V)
    latest=$(echo "$tags" | tail -n 1)
    for tag in $tags; do
      if [ "$tag" != "$latest" ]; then
        echo "删除 $repo:$tag"
        curl -s -X DELETE --unix-socket /var/run/docker.sock \
          http://localhost/images/$repo:$tag
      fi
    done
done
