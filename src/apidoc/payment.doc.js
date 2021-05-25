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
    "data": {
        "count": 2,
        "rows": [
            {
                "id": "3f6d9f5c-e2c1-40f2-9105-dc26b4f14512",
                "walletId": "12e8afec-887c-418e-b419-d997b8e9cf6f",
                "bookingId": "4f1a997e-3175-4da3-beb4-00b690e3efba",
                "price": "-100000",
                "status": "success",
                "createdAt": "2021-05-25T16:01:35.309Z",
                "updatedAt": "2021-05-25T16:01:35.309Z",
                "bookingInfo": {
                    "id": "4f1a997e-3175-4da3-beb4-00b690e3efba",
                    "scheduleDetailId": "62fc9562-371a-4695-8c67-0da181dbc3c5",
                    "createdAt": "2021-05-25T16:01:35.274Z",
                    "scheduleDetailInfo": {
                        "id": "62fc9562-371a-4695-8c67-0da181dbc3c5",
                        "startPeriod": "03:30",
                        "endPeriod": "04:00",
                        "tutorInfo": {
                            "id": "11deb760-de73-46cb-b636-64f00da6f7d8",
                            "name": "Tri Nguyen",
                            "email": "nguyenhuugiatri@gmail.com",
                            "avatar": "http://localhost:3333/avatar/11deb760-de73-46cb-b636-64f00da6f7d8avatar1621946320677.png"
                        }
                    }
                }
            },
            {
                "id": "99f9ba16-180f-48e1-a708-67449e0c076a",
                "walletId": "12e8afec-887c-418e-b419-d997b8e9cf6f",
                "bookingId": null,
                "price": "1000000",
                "status": "success",
                "createdAt": "2021-05-25T12:28:08.142Z",
                "updatedAt": "2021-05-25T12:28:08.142Z",
                "bookingInfo": null
            }
        ]
    }
}
 */
