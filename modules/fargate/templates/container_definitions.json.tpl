[
    {
        "name": "${name}",
        "image": "${image}",
        "cpu": ${cpu},
        "memory": ${memory},
        "mountPoints": [
            {
                "sourceVolume": "${logs_volume_source}",
                "containerPath": "/usr/local/var/log"
            }
        ],
        "portMappings": [
            {
                "containerPort": ${app_port}
            }
        ],
        "environment": [
            {
                "name": "NODE_ENV",
                "value": "${node_env}"
            },
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix": "${name}"
            }
        }
    }
]
