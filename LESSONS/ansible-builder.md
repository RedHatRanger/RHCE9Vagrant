# vim execution-environment.yml
```
---
version: 1
dependencies:
  galaxy: requirements.yml
  python: requirements.txt
  system: bindep.txt

additional_build_steps:
  prepend:
    RUN pip3 install --upgrade pip setuptools
  append:
    - RUN ls -al /
```

# vim requirements.yml
```
---
collections:
  - name: community.aws
```

# vim requirements.txt
```
botocore>=1.18.0
boto3>-1.15.0
boto>=2.49.0
```

# python3-pip install ansible-runner

# podman login
# ansible-builder build -t my_ee -v 3
