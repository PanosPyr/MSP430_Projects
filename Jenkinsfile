pipeline {
    agent any

    stages {
        stage('Git Clone') {
            steps {
               sh "git clone https://github.com/PanosPyr/MSP430_Projects.git"
            }
        }
        stage('Clean Folder') {
            steps {
                dir("${env.WORKSPACE}/MSP430_Projects"){
                    sh "make clean"
                }
            }
        }
        stage('Build Project') {
            steps {
                dir("${env.WORKSPACE}/MSP430_Projects"){
                    sh "make"
                }
            }
        }
    }
}
