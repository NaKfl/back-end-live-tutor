/**
 * @api {get} /payment/wallet Get wallet info
 * @apiName get-wallet
 * @apiGroup Payment
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParamExample Request Param Example:
/payment/wallet
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Get wallet successfully",
    "data": {
        "id": "12e8afec-887c-418e-b419-d997b8e9cf6f",
        "userId": "18e8afec-887c-418e-b419-d997b8e9cf6f",
        "amount": "50000",
        "isBlocked": false,
        "createdAt": "2021-05-25T09:45:18.078Z",
        "updatedAt": "2021-05-25T09:45:18.078Z"
    }
}
 * @apiErrorExample Error: Wallet is blocked
{
    "statusCode": 400,
    "message": "Your wallet is blocked"
}
 */

/**
 * @api {post} /payment/deposit Deposit
 * @apiName deposit
 * @apiGroup Payment
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParamExample Request Body Example:
{
    "price": 1000000
}
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Deposit successfully",
    "data": {
        "id": "12e8afec-887c-418e-b419-d997b8e9cf6f",
        "userId": "18e8afec-887c-418e-b419-d997b8e9cf6f",
        "amount": "1050000",
        "isBlocked": false,
        "createdAt": "2021-05-25T09:45:18.078Z",
        "updatedAt": "2021-05-25T12:28:08.171Z"
    }
}
 * @apiErrorExample Error: Wallet is blocked
{
    "statusCode": 400,
    "message": "Your wallet is blocked"
}
 */

/**
 * @api {get} /payment/history History of transactions
 * @apiName history-transactions
 * @apiGroup Payment
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParamExample Request Param Example:
/payment/history?date=2020-05-25
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Get transaction's history successfully",
    "data": [
        {
            "id": "1cb16cdc-0497-42f6-8f81-43ce4714475f",
            "walletId": "12e8afec-887c-418e-b419-d997b8e9cf6f",
            "bookingId": "3a27402f-7e41-4563-9485-17fe13926382",
            "price": "-100000",
            "status": "success",
            "createdAt": "2021-05-25T12:34:22.793Z",
            "updatedAt": "2021-05-25T12:34:22.793Z",
            "bookingInfo": {
                "id": "3a27402f-7e41-4563-9485-17fe13926382",
                "userId": "18e8afec-887c-418e-b419-d997b8e9cf6f",
                "scheduleDetailId": "5ebb503b-f038-4dd4-8d61-74cc698ac04d",
                "createdAt": "2021-05-25T12:34:22.759Z",
                "updatedAt": "2021-05-25T12:34:22.759Z"
            }
        },
        {
            "id": "f5416ab8-8103-4a3a-855d-89ab4041b6d8",
            "walletId": "12e8afec-887c-418e-b419-d997b8e9cf6f",
            "bookingId": null,
            "price": "40000",
            "status": "success",
            "createdAt": "2021-05-25T12:34:22.793Z",
            "updatedAt": "2021-05-25T12:34:22.793Z",
            "bookingInfo": null
        },
        {
            "id": "b1859165-c25b-4f82-a646-6065229782a7",
            "walletId": "12e8afec-887c-418e-b419-d997b8e9cf6f",
            "bookingId": null,
            "price": "1000",
            "status": "success",
            "createdAt": "2021-05-25T12:34:22.793Z",
            "updatedAt": "2021-05-25T12:34:22.793Z",
            "bookingInfo": null
        }
    ]
}
 */
