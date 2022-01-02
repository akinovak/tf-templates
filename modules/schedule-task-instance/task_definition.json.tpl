[
    {
        "name": "${name}",
        "image": "${image}",
        "mountPoints": [
            {
                "sourceVolume": "${logs_volume_source}",
                "containerPath": "/usr/local/var/log"
            }
        ],
        "logConfiguration": {
            "logDriver": "awslogs",
            "options": {
                "awslogs-group": "${log_group}",
                "awslogs-region": "${region}",
                "awslogs-stream-prefix": "${name}"
            }
        },
         "environment": [
            {
                "name": "MONGODB_URI",
                "value": "${mongo_uri}"
            }
         ]
    }
]
