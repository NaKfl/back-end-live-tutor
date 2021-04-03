/**
 * @api {post} /schedule Get all free time
 * @apiName get-all-free-time
 * @apiGroup Schedule
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} [tutorId] Id of tutor which you want to get the schedules (Note: If this param is null, server will response the schedules of request's owner)
 *
 * @apiParamExample {json} Request Params Example:
{
    "tutorId":"4e85658f-48c7-4128-b0c7-1862d663a0d3"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Get schedules successful",
    "data": {
        "2021-03-12": [
            {
                "id": "6fc9362e-687c-4a90-99ea-d66c5096e0ca",
                "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
                "startTime": "09:00",
                "endTime": "11:00",
                "createdAt": "2021-04-01T12:11:59.001Z",
                "isBooked": true
            }
        ],
        "2021-03-13": [
            {
                "id": "141f7613-d7b4-44f8-8f5b-8522c375a7df",
                "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
                "startTime": "09:00",
                "endTime": "11:00",
                "createdAt": "2021-04-01T12:31:12.641Z",
                "isBooked": true
            }
        ],
    }
}
 *
 */

/**
 * @api {post} /schedule Get free time in a date
 * @apiName get-free-time-in-a-date
 * @apiGroup Schedule
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} [date] Date in format YYYY-MM-DD
 * @apiParam {String} [tutorId] Id of tutor which you want to get the schedules (Note: If this param is null, server will response the schedules of request's owner)
 *
 * @apiParamExample {json} Request Params Example:
/schedule?date=2021-03-29
{
    "tutorId":"4e85658f-48c7-4128-b0c7-1862d663a0d3"
}
 *
 * @apiSuccessExample Success Response Example:
{
  "message": "Get schedules successful",
  "data": [
    {
      "id": "2fd335c6-61e7-4538-8c03-5a9a560c3548",
      "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
      "startTime": "09:00",
      "endTime": "11:00",
      "createdAt": "2021-03-30T04:30:17.830Z",
      "isBooked": true,
      "scheduleDetails": [
        {
          "id": "c88d56bc-0d51-48e5-9d34-ed2e3080d3e8",
          "scheduleId": "2fd335c6-61e7-4538-8c03-5a9a560c3548",
          "startPeriod": "09:30",
          "endPeriod": "10:00",
          "createdAt": "2021-03-30T04:30:17.832Z",
          "updatedAt": "2021-03-30T04:30:17.832Z",
          "isBooked": true
        },
        {
          "id": "86718670-0a7c-4ae4-8c7b-ebb0c61a9b67",
          "scheduleId": "2fd335c6-61e7-4538-8c03-5a9a560c3548",
          "startPeriod": "10:30",
          "endPeriod": "11:00",
          "createdAt": "2021-03-30T04:30:17.832Z",
          "updatedAt": "2021-03-30T04:30:17.832Z",
          "isBooked": true
        },
      ]
    },
    {
      "id": "3c471b2b-7c42-4474-ad0c-9d4107e3d658",
      "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
      "startTime": "07:15",
      "endTime": "07:45",
      "createdAt": "2021-03-31T11:39:28.421Z",
      "isBooked": false,
      "scheduleDetails": []
    }
  ]
}
 *
 */

/**
 * @api {get} /schedule/:scheduleId Get detail of a schedule
 * @apiName get-detail-schedule
 * @apiGroup Schedule
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} scheduleId Id of schedule
 *
 * @apiParamExample {json} Request Body Example:
/schedule/19dbf64a-8751-4380-a8a6-8daa49a782da
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Get schedule details successful",
    "data": [
        {
            "id": "710f987f-a361-4cc1-a5f1-1871b70ccb8e",
            "scheduleId": "19dbf64a-8751-4380-a8a6-8daa49a782da",
            "startPeriod": "08:00",
            "endPeriod": "08:30",
            "createdAt": "2021-03-31T14:35:19.017Z",
            "updatedAt": "2021-03-31T14:35:19.017Z",
            "isBooked": false
        },
        {
            "id": "c0f2092e-d320-429b-9546-8ddb816a2b25",
            "scheduleId": "19dbf64a-8751-4380-a8a6-8daa49a782da",
            "startPeriod": "08:30",
            "endPeriod": "09:00",
            "createdAt": "2021-03-31T14:35:19.017Z",
            "updatedAt": "2021-03-31T14:35:19.017Z",
            "isBooked": false
        }
    ]
}
 *
 */

/**
 * @api {post} /schedule/register Register new schedule
 * @apiName register-schedule
 * @apiGroup Schedule
 *
 * @apiPermission Tutor
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} date Date in format YYYY-MM-DD
 * @apiParam {String} startTime Start time in format HH:mm
 * @apiParam {String} endTime End time in format HH:mm
 *
 * @apiParamExample {json} Request Body Example:
{
    "date":"2021-03-29",
    "startTime":"07:15",
    "endTime":"07:45"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Register schedule successful",
    "data": {
        "date": "2021-03-29",
        "createdAt": "2021-03-31T11:39:28.421Z",
        "updatedAt": "2021-03-31T11:39:28.421Z",
        "id": "3c471b2b-7c42-4474-ad0c-9d4107e3d658",
        "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
        "startTime": "07:15",
        "endTime": "07:45"
    }
}
 *
 * @apiErrorExample Error: End time greater than start time
{
    "statusCode": 400,
    "message": "End time should be greater than start time"
}
 * @apiErrorExample Error: Period must be divisible by MINUTES_PER_SESSION
{
    "statusCode": 400,
    "message": "The period must be divisible by MINUTES_PER_SESSION"
}
 * @apiErrorExample Error: Booking duplicate
{
    "statusCode": 400,
    "message": "Booking duplicate"
}
 */

/**
 * @api {delete} /schedule/:scheduleId Unregister schedule
 * @apiName unregister-schedule
 * @apiGroup Schedule
 *
 * @apiPermission Tutor
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} scheduleId Id of schedule
 *
 * @apiParamExample {json} Request Body Example:
/schedule/5e53dfbc-f29b-4597-a4ef-979d524a7752
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Unregister schedule successful"
}
 *
 * @apiErrorExample Error: Unregister failed
{
    "message": "Can't unregister this schedule"
}
 */
