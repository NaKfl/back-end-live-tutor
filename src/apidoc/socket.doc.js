/**
 * @api {emit} connection:login Connection: Login
 * @apiName connection-login
 * @apiGroup Socket
 * @apiDescription Emit when the user was logged in to add to online user list
 *
 * @apiParam {Object} user Information of user (Can get from local storage)
 *
 * @apiParamExample {json} Request Data Example:
{
  user: {
    "id": "88e1f4db-a818-4bd6-8184-271aaf6283d5",
    "email": "lem@gmail.com",
    "name": null,
    "avatar": null,
    "country": null,
    "phone": null
  }
}
 *
 * @apiSuccessExample Success Response Example:
No data response
 *
 */

/**
 * @api {emit} disconnection:logout Disconnection: Logout
 * @apiName disconnection-logout
 * @apiGroup Socket
 * @apiDescription Emit when the user was logged out to remove from online user list (No data request and response)
 *
 * @apiParamExample {json} Request Data Example:
No data request
 *
 * @apiSuccessExample Success Response Example:
No data response
 *
 */

/**
 * @api {emit} chat:getMessages Chat: Get messages
 * @apiName chat-get-messages
 * @apiGroup Socket
 * @apiDescription After emit this event, please listen event `chat:returnMessages`
 *
 * @apiParam {String} fromId Id of sender
 * @apiParam {String} toId Id of receiver
 *
 * @apiParamExample {json} Request Data Example:
{
  "fromId": "88e1f4db-a818-4bd6-8184-271aaf6283d5",
  "toId": "88e1f4db-a818-4bs6-8184-271aaf6243d1"
}
 *
 * @apiSuccessExample Success Response Example:
No data response
 *
 */

/**
 * @api {emit} chat:sendMessage Chat: Send message
 * @apiName chat-send-message
 * @apiGroup Socket
 * @apiDescription After emit this event, please listen event `chat:returnMessages`
 *
 * @apiParam {String} fromId Id of sender
 * @apiParam {String} toId Id of receiver
 * @apiParam {String} content Content of message
 *
 * @apiParamExample {json} Request Data Example:
{
  "fromId": "88e1f4db-a818-4bd6-8184-271aaf6283d5",
  "toId": "88e1f4db-a818-4bs6-8184-271aaf6243d1",
  "content": "nike two meat yu"
}
 *
 * @apiSuccessExample Success Response Example:
No data response
 *
 */

/**
 * @api {on} chat:returnMessages Chat: Return messages
 * @apiName chat-return-messages
 * @apiGroup Socket
 * @apiDescription Listen this event to update conversation
 *
 * @apiParamExample {json} Request Data Example:
No data request
 *
 * @apiSuccessExample Success Response Example:
{
  messages:[
  {
    "id": "b05f55d7-eb6d-4c1a-8c26-15ebfcc3051a",
    "content": "hi",
    "createdAt": "2021-03-22T21:14:24.635Z",
    "updatedAt": "2021-03-22T21:14:24.636Z",
    "fromInfo": {
      "id": "82918135-973a-4d4c-a003-a82415377580",
      "name": "Gia Tri"
    },
    "toInfo": {
      "id": "205a3a59-0280-4879-9e93-611e637c5843",
      "name": "Humberto Gulgowski"
    }
  },
  {
    "id": "7c6931a8-eeaa-4828-80ce-44dce4b877a7",
    "content": "nice to meet you",
    "createdAt": "2021-03-23T10:12:53.364Z",
    "updatedAt": "2021-03-23T10:12:53.364Z",
    "fromInfo": {
      "id": "82918135-973a-4d4c-a003-a82415377580",
      "name": "Gia Tri"
    },
    "toInfo": {
      "id": "205a3a59-0280-4879-9e93-611e637c5843",
      "name": "Humberto Gulgowski"
    }
  }
]
}
 *
 */

/**
 * @api {emit} chat:getRecentList Chat: Get recent conversations
 * @apiName chat-get-recent-list
 * @apiGroup Socket
 * @apiDescription After emit this event, please listen event `chat:returnRecentList`
 *
 * @apiParamExample {json} Request Data Example:
No data request
 *
 * @apiSuccessExample Success Response Example:
No data response
 *
 */

/**
 * @api {on} chat:returnRecentList Chat: Return recent conversations
 * @apiName chat-return-recent-list
 * @apiGroup Socket
 * @apiDescription Listen this event to update recent conversations. Note: `partner` in response is information whose talk to owner of emit event `chat:getRecentList`
 *
 * @apiParamExample {json} Request Data Example:
No data request
 *
 * @apiSuccessExample Success Response Example:
{
  recentList:[
    {
      "id": "9f222896-388a-4ede-8413-d10565eae402",
      "content": "hi",
      "createdAt": "2021-03-24T00:00:53.897Z",
      "updatedAt": "2021-03-24T00:00:53.897Z",
      "fromInfo": {
        "id": "7a11fe4d-c111-4756-aa4b-b278077a66ba",
        "name": "Zelma Romaguera",
        "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png"
      },
      "toInfo": {
        "id": "d5e24816-515c-4dce-811b-fca31113850d",
        "name": "Raheem Shields",
        "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png"
      },
      "partner": {
        "id": "d5e24816-515c-4dce-811b-fca31113850d",
        "name": "Raheem Shields",
        "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
        "isOnline": false
      }
    },
    {
      "id": "16cd3758-3e3f-42e8-acff-b922189cc96a",
      "content": "hi",
      "createdAt": "2021-03-24T00:00:01.791Z",
      "updatedAt": "2021-03-24T00:00:01.791Z",
      "fromInfo": {
        "id": "7a11fe4d-c111-4756-aa4b-b278077a66ba",
        "name": "Zelma Romaguera",
        "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png"
      },
      "toInfo": {
        "id": "78ad7a58-c16e-4406-8ed1-aaf6a6d421c2",
        "name": "Trí Nguyễn",
        "avatar": "https://lh3.googleusercontent.com/a-/AOh14GjteEF6UEflGnA7ndsHujtYp-qU6EdwqmNzMXUmVw=s96-c"
      },
      "partner": {
        "id": "78ad7a58-c16e-4406-8ed1-aaf6a6d421c2",
        "name": "Trí Nguyễn",
        "avatar": "https://lh3.googleusercontent.com/a-/AOh14GjteEF6UEflGnA7ndsHujtYp-qU6EdwqmNzMXUmVw=s96-c",
        "isOnline": false
      }
    }
  ]
}
 *
 */

/**
 * @api {on} chat:joinOrLeave Chat: Update recent conversations
 * @apiName chat-join-or-leave
 * @apiGroup Socket
 * @apiDescription This event will be emitted when any user connect or disconnect. Listen this event to emit `chat:getRecentList` to update recent conversations
 *
 * @apiParamExample {json} Request Data Example:
No data request
 *
 * @apiSuccessExample Success Response Example:
No data response
 *
 */
