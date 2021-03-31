/**
 * @api {get} /schedule Get all free time
 * @apiName get-all-free-time
 * @apiGroup Schedule
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} [tutorId] Id of tutor which you want to get the schedules (Note: If this param is null, server will response the schedules of request's owner)
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Get schedules successful",
    "data": {
        "2022-01-08": [
            {
                "id": "b9279afe-22a3-4f19-b545-ad01083b2972",
                "tutorId": "96f4af6a-4575-4d57-8f5a-878581d7b43b",
                "startTime": "18:33",
                "endTime": "21:45",
                "createdAt": "2021-03-29T18:34:55.812Z"
            }
        ],
        "2021-03-29": [
            {
                "id": "9de90658-3f1c-4b3d-8435-07cc087a050f",
                "tutorId": "96f4af6a-4575-4d57-8f5a-878581d7b43b",
                "startTime": "01:00",
                "endTime": "2:00",
                "createdAt": "2021-03-30T14:58:31.313Z"
            },
            {
                "id": "2167ccbd-0d1f-452f-8af3-3340e6a83ca0",
                "tutorId": "96f4af6a-4575-4d57-8f5a-878581d7b43b",
                "startTime": "02:00",
                "endTime": "2:30",
                "createdAt": "2021-03-30T15:04:45.951Z"
            }
        ]
    }
}
 *
 */

/**
 * @api {get} /schedule Get free time in a date
 * @apiName get-free-time-in-a-date
 * @apiGroup Schedule
 *
 * @apiPermission Tutor
 * @apiHeader {String} Authorization Access token
 *
 * @apiParam {String} [date] Date in format YYYY-MM-DD
 *
 * @apiParamExample {json} Request Params Example:
/schedule?date=2021-03-29
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Get schedules successful",
    "data": [
        {
            "id": "82ffe0cd-4580-4246-9da1-8f574d830e13",
            "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
            "startTime": "09:00",
            "endTime": "11:00",
            "createdAt": "2021-03-30T03:08:33.466Z",
            "isBooked": true
        },
        {
            "id": "2fd335c6-61e7-4538-8c03-5a9a560c3548",
            "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
            "startTime": "09:00",
            "endTime": "11:00",
            "createdAt": "2021-03-30T04:30:17.830Z",
            "isBooked": true
        },
        {
            "id": "57a4c301-b9df-4bd9-a109-dfe53ff9ee08",
            "tutorId": "4e85658f-48c7-4128-b0c7-1862d663a0d3",
            "startTime": "09:00",
            "endTime": "11:00",
            "createdAt": "2021-03-30T04:44:50.911Z",
            "isBooked": true
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
 * @api {post} /schedule Register new schedule
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
