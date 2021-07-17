#auth into registry
docker login <registry-url> --username <uname> --password <pass>

#tag local image before pushing
docker tag <existing-image-name> <registry-url>/<remote-image-name>:<version>
docker tag app-name foobar.com/app-name:latest

#push local image to remote docker repo
docker push <registry-url>/<image-name>:<version>