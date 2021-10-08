# API Calls and Responses

### POST /login
```
Request:
POST http://localhost:3000/api/v0/login
{
	"email": "abc@gmail.com",
	"password": "123456"
}

Response:
{
"auth_token": "eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxfQ.JC6qKuH9SG0SIiYSfhZUFTtirxN9Q47buLk0DPFFFzE",
"message": "user authenticated"
}
```
### POST /assessments
```
WITHOUT INCLUDE:
POST http://localhost:3000/api/v0/assessments/
Request:
{
  "data": {
    "type": "assessments",
    "attributes": {
      "rating": 5,
      "player_id": 1,
      "tournament_id": 1,
      "assessment_type": "tournament",
      "assessment_notes_attributes": [
        {
          "note": "AHHHH!"
        }
      ]
    }
  }
}

Response:
{
    "data": {
        "id": "2",
        "type": "assessment",
        "attributes": {
            "rating": 5,
            "user_id": 1,
            "player_id": 1,
            "tournament_id": 1,
            "assessment_type": "event",
            "created_at": "2021-10-08T19:41:21.051Z",
            "updated_at": "2021-10-08T19:41:21.051Z"
        },
        "relationships": {
            "assessment_notes": {
                "data": [
                    {
                        "id": "2",
                        "type": "assessment_note"
                    }
                ]
            }
        }
    }
}

WITH INCLUDE:NOTES
POST http://localhost:3000/api/v0/assessments/?include=notes
Request:
{
  "data": {
    "type": "assessments",
    "attributes": {
      "rating": 5,
      "player_id": 1,
      "tournament_id": 1,
      "assessment_type": "tournament",
      "assessment_notes_attributes": [
        {
          "note": "AHHHH!"
        }
      ]
    }
  }
}

Response:
{
    "data": {
        "id": "6",
        "type": "assessment",
        "attributes": {
            "rating": 5,
            "user_id": 1,
            "player_id": 1,
            "tournament_id": 1,
            "assessment_type": "event",
            "created_at": "2021-10-08T19:47:09.681Z",
            "updated_at": "2021-10-08T19:47:09.681Z"
        },
        "relationships": {
            "assessment_notes": {
                "data": [
                    {
                        "id": "6",
                        "type": "assessment_note"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "id": "6",
            "type": "assessment_note",
            "attributes": {
                "note": "AHHHH!",
                "user_id": 1,
                "assessment_id": 6,
                "created_at": "2021-10-08T19:47:09.700Z",
                "updated_at": "2021-10-08T19:47:09.700Z"
            }
        }
    ]
}
```
### GET /assessments/{:assessment_id}
```
WITHOUT INCLUDE: NOTES
Request:
GET http://localhost:3000/api/v0/assessments/1
Response:
{
    "data": {
        "id": "1",
        "type": "assessment",
        "attributes": {
            "rating": 5,
            "user_id": 1,
            "player_id": 1,
            "tournament_id": 1,
            "assessment_type": "event",
            "created_at": "2021-10-08T19:40:18.369Z",
            "updated_at": "2021-10-08T19:40:18.369Z"
        },
        "relationships": {
            "assessment_notes": {
                "data": [
                    {
                        "id": "1",
                        "type": "assessment_note"
                    }
                ]
            }
        }
    }
}

WITH INCLUDE: NOTES
Request:
GET 'http://localhost:3000/api/v0/assessments/1?include=notes

Response:
{
    "data": {
        "id": "1",
        "type": "assessment",
        "attributes": {
            "rating": 5,
            "user_id": 1,
            "player_id": 1,
            "tournament_id": 1,
            "assessment_type": "event",
            "created_at": "2021-10-08T19:40:18.369Z",
            "updated_at": "2021-10-08T19:40:18.369Z"
        },
        "relationships": {
            "assessment_notes": {
                "data": [
                    {
                        "id": "1",
                        "type": "assessment_note"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "id": "1",
            "type": "assessment_note",
            "attributes": {
                "note": "WEE WOO WEE WOO",
                "user_id": 1,
                "assessment_id": 1,
                "created_at": "2021-10-08T19:40:18.390Z",
                "updated_at": "2021-10-08T19:40:18.390Z"
            }
        }
    ]
}
```
### DELETE /assessments/{:assessment_id}
```
Request:
http://localhost:3000/api/v0/assessments/1

Response:
Currently unable to delete to do unexpected table referencing assessment through notes
```

### POST /notes
```
Request:
POST http://localhost:3000/api/v0/notes
{
  "data": {
    "type": "assessment_notes",
    "attributes": {
      "note": "He's our center back. He's our number 4.",
      "assessment_id": 1
    }
  }
}

Response:
{
    "data": {
        "id": "7",
        "type": "assessment_note",
        "attributes": {
            "note": "He's our center back. He's our number 4.",
            "user_id": 1,
            "assessment_id": 1,
            "created_at": "2021-10-08T20:16:09.688Z",
            "updated_at": "2021-10-08T20:16:09.688Z"
        }
    }
}
```

### PATCH /notes/{:note_id}
```
Request:
PATCH http://localhost:3000/api/v0/notes

Response:
{
    "data": {
        "id": "1",
        "type": "assessment_note",
        "attributes": {
            "note": "Reflection of data change",
            "user_id": 1,
            "assessment_id": 1,
            "created_at": "2021-10-08T19:40:18.390Z",
            "updated_at": "2021-10-08T20:19:44.592Z"
        }
    }
}
```
### DELETE /notes/{:note_id}
```
Request:
DELETE http://localhost:3000/api/v0/notes/1

Response:
{
    "data": {
        "message": "assessment note deleted"
    }
}
```

### GET /players
```
Request:
GET http://localhost:3000/api/v0/players

Response:
{
    "data": [
        {
            "id": "1",
            "type": "players",
            "attributes": {
                "first_name": "Leigh",
                "last_name": "Pulzone",
                "height": 60,
                "weight": 250,
                "birthday": "1989-07-17",
                "graduation_year": 2008,
                "position": "Linebacker",
                "recruit": true
            }
        }
    ]
}
```

### GET /players/{:player_id}
```
WITHOUT INCLUDE: PLAYERS
Request: 
http://localhost:3000/api/v0/players/1

Response:
{
    "data": {
        "id": "1",
        "type": "players",
        "attributes": {
            "first_name": "Leigh",
            "last_name": "Pulzone",
            "height": 60,
            "weight": 250,
            "birthday": "1989-07-17",
            "graduation_year": 2008,
            "position": "Linebacker",
            "recruit": true
        }
    }
}
```

### GET /teams/{:team_id}
```
WITHOUT INCLUDE: PLAYERS
Request:
GET http://localhost:3000/api/v0/teams/1

Response:
{
    "data": {
        "id": "1",
        "type": "teams",
        "attributes": {
            "name": "The Bobcats",
            "age_group": "N/A"
        },
        "relationships": {
            "players": {
                "data": [
                    {
                        "id": "1",
                        "type": "players"
                    }
                ]
            }
        }
    }
}

WITH INCLUDE: PLAYERS
Request:
http://localhost:3000/api/v0/teams/1?include=players

Response:
{
    "data": {
        "id": "1",
        "type": "teams",
        "attributes": {
            "name": "The Bobcats",
            "age_group": "N/A"
        },
        "relationships": {
            "players": {
                "data": [
                    {
                        "id": "1",
                        "type": "players"
                    }
                ]
            }
        }
    },
    "included": [
        {
            "id": "1",
            "type": "players",
            "attributes": {
                "first_name": "Leigh",
                "last_name": "Pulzone",
                "height": 60,
                "weight": 250,
                "birthday": "1989-07-17",
                "graduation_year": 2008,
                "position": "Linebacker",
                "recruit": true
            }
        }
    ]
}
```