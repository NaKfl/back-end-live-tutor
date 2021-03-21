/**
 * @api {post} /auth/login Login
 * @apiName login
 * @apiGroup Auth
 *
 * @apiParam {String} email Email of the user.
 * @apiParam {String} password Password of the user.
 *
 * @apiParamExample {json} Request Body Example:
{
    "email": "o0liebeo0o@gmail.com",
    "password":"123123"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "user": {
        "id": "ba5c598b-5b74-4a09-9a29-eb4cf1f6c8ba",
        "email": "o0liebeo0o@gmail.com",
        "name": "Trí Nguyễn",
        "avatar": "https://lh3.googleusercontent.com/a-/AOh14GjteEF6UEflGnA7ndsHujtYp-qU6EdwqmNzMXUmVw=s96-c",
        "country": null,
        "phone": null
    },
    "tokens": {
        "access": {
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJiYTVjNTk4Yi01Yjc0LTRhMDktOWEyOS1lYjRjZjFmNmM4YmEiLCJpYXQiOjE2MTYzNjUwOTAsImV4cCI6MTYxNjM2Njg5MCwidHlwZSI6ImFjY2VzcyJ9.7pqN6mvm6g3G1PNYzy2RZgRfvXVjcnQCtDAww9a1dCU",
            "expires": "2021-03-21T22:48:10.628Z"
        }
    }
}
 *
 * @apiErrorExample Error: Incorrect email or password
{
    "statusCode": 401,
    "message": "Incorrect email or password"
}
 *
 */

/**
 * @api {post} /auth/register Register
 * @apiName register
 * @apiGroup Auth
 *
 * @apiParam {String} email Email of the user.
 * @apiParam {String} password Password of the user.
 *
 * @apiParamExample {json} Request Body Example:
{
    "email": "lem@gmail.com",
    "password":"123123"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "user": {
        "id": "88e1f4db-a818-4bd6-8184-271aaf6283d5",
        "email": "lem@gmail.com",
        "name": null,
        "avatar": null,
        "country": null,
        "phone": null
    },
    "tokens": {
        "access": {
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI4OGUxZjRkYi1hODE4LTRiZDYtODE4NC0yNzFhYWY2MjgzZDUiLCJpYXQiOjE2MTYzNjU3NjIsImV4cCI6MTYxNjM2NzU2MiwidHlwZSI6ImFjY2VzcyJ9.RvwnGddw_FYXn2deKGGm9erNJB1fafg9SE9KEsHfStI",
            "expires": "2021-03-21T22:59:22.375Z"
        }
    }
}
 * @apiErrorExample Error: Email already taken
{
    "statusCode": 400,
    "message": "Email already taken"
}
 *
 */

/**
 * @api {post} /auth/google Login with Google
 * @apiName google
 * @apiGroup Auth
 *
 * @apiParam {String} access_token Access token from Google.
 *
 * @apiParamExample {json} Request Body Example:
{
    "access_token": "ya29.a0AfH6SMBCKrDqyWPf_xndAZogp7rsVGrEVoWYvTHlQhnpnPHtDqtZkTzAW6NMnsvj4T4y9_TdXEBvhzNyFCBxofEpgkIzXBvf2_oS-tO7T_mfDhT-dlGqOAlnWa2BtXbynpaXKr03IkeEKWX5mjh_v1-HKqJZ"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "user": {
        "id": "69803d5a-c037-4f85-b72d-6ebd53122e37",
        "email": "nguyenhuugiatri@gmail.com",
        "google": "114803034081374163566",
        "facebook": null,
        "avatar": "https://lh3.googleusercontent.com/a-/AOh14GjejYQnA2KjGknELKu5d9WaxIIXu4EVu-2Vy0Tl4w=s96-c",
        "name": "Trí Nguyễn Hữu Gia",
        "country": null,
        "phone": null,
        "language": null,
        "birthday": null,
        "isActivated": false,
        "createdAt": "2021-03-21T22:43:23.841Z",
        "updatedAt": "2021-03-21T22:43:23.841Z",
        "deletedAt": null
    },
    "tokens": {
        "access": {
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2OTgwM2Q1YS1jMDM3LTRmODUtYjcyZC02ZWJkNTMxMjJlMzciLCJpYXQiOjE2MTYzNjY2NzYsImV4cCI6MTYxNjM2ODQ3NiwidHlwZSI6ImFjY2VzcyJ9.FlS_ETXZ6IWz8GhGD-9-CWnl7oYrQ4QwLoqo8Usb-sU",
            "expires": "2021-03-21T23:14:36.589Z"
        }
    }
}
 *
 */

/**
 * @api {post} /auth/facebook Login with Facebook
 * @apiName facebook
 * @apiGroup Auth
 *
 * @apiParam {String} access_token Access token from Facebook.
 *
 * @apiParamExample {json} Request Body Example:
{
    "access_token": "EAADdwH3MPecBAA7UrsOtxwG2cj6JqPpLQIs1cjaWzxyHt2K23lBHsUOa3EWC9cBZCgcKY9Is18LgIZBwcziOXWzQXOGa1kA5zcaZCn9mSsEZAAAPR2kc9GPpjshT8itZAliuSPQlOUdP16ZBaK9X5ZB5Q2OqhxFi8bzZCWtdaqVo8FdEhk0AoCoBd6Pv5hIl1jcQH3Rj9stTaUH0kdLZC4rutHIH4jSu8QWEZD"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "user": {
        "id": "69803d5a-c037-4f85-b72d-6ebd53122e37",
        "email": "nguyenhuugiatri@gmail.com",
        "google": "114803034081374163566",
        "facebook": "3491620604268372",
        "avatar": "https://lh3.googleusercontent.com/a-/AOh14GjejYQnA2KjGknELKu5d9WaxIIXu4EVu-2Vy0Tl4w=s96-c",
        "name": "Trí Nguyễn Hữu Gia",
        "country": null,
        "phone": null,
        "language": null,
        "birthday": null,
        "isActivated": false,
        "createdAt": "2021-03-21T22:43:23.841Z",
        "updatedAt": "2021-03-21T22:47:12.898Z",
        "deletedAt": null
    },
    "tokens": {
        "access": {
            "token": "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiI2OTgwM2Q1YS1jMDM3LTRmODUtYjcyZC02ZWJkNTMxMjJlMzciLCJpYXQiOjE2MTYzNjY4NDksImV4cCI6MTYxNjM2ODY0OSwidHlwZSI6ImFjY2VzcyJ9.lH9onsz4m6NTghVLOQ8_2FlAEPSiBPT7Tr811fUaltw",
            "expires": "2021-03-21T23:17:29.955Z"
        }
    }
}
 *
 */
