/**
 * @api {post} /booking Book new call schedule
 * @apiName book
 * @apiGroup Booking
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {Array} scheduleDetailIds Array of schedule detail ids
 *
 * @apiParamExample {json} Request Body Example:
{
  "scheduleDetailIds":["710f987f-a361-4cc1-a5f1-1871b70ccb8e","c0f2092e-d320-429b-9546-8ddb816a2b25"]
}
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Book successful",
    "data": [
        {
            "createdAt": "2021-03-31T14:35:18.996Z",
            "updatedAt": "2021-03-31T14:35:18.996Z",
            "id": "f5de56d3-5e90-4065-9f81-75a131ab8d87",
            "userId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
            "scheduleDetailId": "710f987f-a361-4cc1-a5f1-1871b70ccb8e"
        },
        {
            "createdAt": "2021-03-31T14:35:18.996Z",
            "updatedAt": "2021-03-31T14:35:18.996Z",
            "id": "63979436-f077-4da8-bc36-8a0d04ed57ad",
            "userId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
            "scheduleDetailId": "c0f2092e-d320-429b-9546-8ddb816a2b25"
        }
    ]
}
 *
 * @apiErrorExample Error: Booking already exists
{
    "statusCode": 400,
    "message": "Booking already exists"
}
 * @apiErrorExample Error: Not enough money
{
  "statusCode": 400,
  "message": "Not enough money"
}
 */

/**
 * @api {delete} /booking Cancel booking call schedule
 * @apiName cancel-booking
 * @apiGroup Booking
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {Array} scheduleDetailIds Array of schedule detail ids
 *
 * @apiParamExample {json} Request Body Example:
{
  "scheduleDetailIds":["710f987f-a361-4cc1-a5f1-1871b70ccb8e","c0f2092e-d320-429b-9546-8ddb816a2b25"]
}
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Cancel booking successful"
}
 *
 * @apiErrorExample Error: Permission of owner
{
    "message": "Permission denied"
}
 */
