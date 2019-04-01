pipeline {
    agent any
    stages{
        stage('Checkout'){
            steps{
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[url: 'https://github.com/rosaldogarcia/devops_pipeline_demo.git/']]])
            }
        }
        stage('Build'){
            steps{
                echo "...Build Phase Started:: Compiling Source Code ::....."
                dir('java_web_code'){
                    sh 'mvn install'
                }
            }
        }
        stage('Test'){
            steps{
                echo "...Build Phase Started:: Compiling Source Code ::....."
                dir('integration-testing'){
                    sh 'mvn clean verify -P integration-test'
                    dir('docker'){
                        sh label: '', script: '/bin/cp /home/jenkins/.jenkins/workspace/MySecondPipeline/docker/wildfly-spring-boot-sample-1.0.0.war /home/jenkins/.jenkins/workspace/MySecondPipeline/integration-testing/target'
                    }
                }
            }
        }
        stage('Build Docker'){
            steps{
                echo "Provisioning Phase Started::Building Docker Container"
                dir('docker'){
                    sh label: '', script: 'docker build -t devops_pipeline_demo .'
                }
            }
        }
        stage('Run Container'){
            steps{
                echo "Provisioning Phase Started::Building Docker Container"
                dir('docker'){
                  sh label: '', script: '''CONTAINER=devops_pipeline_demo
 
RUNNING=$(docker inspect --format="{{ .State.Running }}" $CONTAINER 2> /dev/null)

if [ "$RUNNING" == false ]; then
  echo "\'$CONTAINER\' does not exist."
else
  docker rm -f $CONTAINER
fi
    echo ""
	echo "..... Deployment Phase Started :: Building Docker Container :: ......"
	docker run -d -p 8180:8080 --name devops_pipeline_demo devops_pipeline_demo

echo "--------------------------------------------------------"
echo "View App deployed here: http://10.200.3.147:8180/"
echo "--------------------------------------------------------"'''
                }
            }
        }
    }
}

    
    
