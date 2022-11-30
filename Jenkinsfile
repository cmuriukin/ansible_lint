pipeline {
   agent any

   stages {
      stage('Clone WebApp') {
            steps {
            git credentialsId: '06d9395d-581c-4298-965f-03221aaf1172', url: 'https://github.com/cmuriukin/ansible_lint.git', branch: 'main'
            }
      }

      stage('Installation playbooks') {
         steps {
            sh 'apt-get install -ys ansible-lint'
         }
      }
      stage('Testing playbooks lint') {
         steps {
            sh '''
                  #!/bin/bash
                  errno=0
                  while read -d $'\0' -r file
                  do
                     # file has a .yaml extention
                     ext=${file:(-5)}
                     [[ $ext != ".yaml" ]] && continue
                     ./ansible-lint $file

                     err=$?
                     if [[ $err != "0" ]]
                     then
                        errno=$err
                     fi
                  done < <(git diff --name-only -z HEAD 'HEAD^1')
                  exit $errno
                  '''

         //sh 'ansible-lint test.yaml'
         }
      }
      stage('Testing playbooks syntax') {
         steps {
            sh 'ansible-playbook nginx.yaml  --syntax-check'
         //sh 'ansible-playbook test.yaml  --syntax-check'
         }
      }

      stage('Testing playbooks check --dry-run') {
         steps {
            sh 'ansible-playbook nginx.yaml  --check'
         //sh 'ansible-playbook test.yaml  --syntax-check'
         }
      }
      stage('Uninstall playbooks') {
         steps {
            sh 'echo "ansible-lint uninstall/playbooks/*.yml" '
         }
      }
   }
}
