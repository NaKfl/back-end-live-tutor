/**
 * @api {emit} identity Identity: Connection
 * @apiName identity-connect
 * @apiGroup Socket
 * @apiDescription Emit when the user was logged in
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
 * @api {emit} logout Identity: Logout
 * @apiName identity-logout
 * @apiGroup Socket
 * @apiDescription Emit when the user was logged out (No data request and response)
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
 * @apiParam {String} fromId Id of sender
 * @apiParam {String} toId Id of receiver
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
    "fromId": "82918135-973a-4d4c-a003-a82415377580",
    "toId": "205a3a59-0280-4879-9e93-611e637c5843",
    "createdAt": "2021-03-22T21:14:24.635Z",
    "updatedAt": "2021-03-22T21:14:24.636Z",
    "fromInfo": {
      "name": "Gia Tri"
    },
    "toInfo": {
      "name": "Humberto Gulgowski"
    }
  },
  {
    "id": "7c6931a8-eeaa-4828-80ce-44dce4b877a7",
    "content": "nice to meet you",
    "fromId": "82918135-973a-4d4c-a003-a82415377580",
    "toId": "205a3a59-0280-4879-9e93-611e637c5843",
    "createdAt": "2021-03-23T10:12:53.364Z",
    "updatedAt": "2021-03-23T10:12:53.364Z",
    "fromInfo": {
      "name": "Gia Tri"
    },
    "toInfo": {
      "name": "Humberto Gulgowski"
    }
  }
]
}
 *
 */
