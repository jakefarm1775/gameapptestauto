pipeline
{
    agent any
    enviroment
    {
        // Docker hub credentails ID stored in Jenkins
        DOCKERHUB_CREDENTIALS = 'cyber-3120'
        IMAGE_NAME = 'jakefarm1775/jakegametest123'
    }

    stages
    {
        stage ('cloning Git')
        {
            steps
            {
                checkout scm
            }
        }

        stage ('SAST')
        {
            steps
            {
                sh 'echo running SAST scan with snyk...'
            }
        }

        stage ('BUILD-AND-TAG')
        {
            agent { lable 'appserver'}

            steps { 
                script
                {
                    // Build Docker Image Using Jenkins Pipeline API
                    echo "BUILDING DOCKER IMAGE ${IMAGE_NAME}..."
                    app = docker.build("${IMAGE_NAME}")
                    app.tag("latest")

                }
            }
        }

         stage ('SAST')
        {
            steps
            {
                sh 'echo running SAST scan with snyk...'
            }
        }

        stage ('POST-TO-DOCKERHUB')
        {
            agent { lable 'appserver'}

            steps { 
                script
                {
                   echo "push image ${IMAGE_NAME}:latest to Docker Hub..."
                   docker.withRegistry('https://registry.hub.docker.com',"${DOCKERHUB_CREDENTIALS}")
                   {
                    app.push("latest")
                   }
                    
                }
            }
        }
        
        stage ('DAST')
        {
            steps
            {
                sh 'echo running DAST scan...'
            }
        }

         stage ('DEPLOYMENT')
        {
            agent { lable 'appserver'}

            steps
             { 
                echo 'starting deployment using docker-compose...'
                script
                {
                  dir("${WORKSPACE}")
                  {
                    sh '''
                        docker-compose down
                        docker-compose up -d
                        docker ps    
                    '''
                
                  }
                    
                }
                echo 'Deployment completed successfully'
             }
        }
    }

}
