/**
/**
 * @api {get} /user/info Get info of user
 * @apiName info
 * @apiGroup User
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParamExample Request Param Example:
/user/info
 *
 * @apiSuccessExample Success Response Example:
{
    "user": {
        "id": "18e8afec-887c-418e-b419-d997b8e9cf6f",
        "email": "student@gmail.com",
        "google": null,
        "facebook": null,
        "avatar": null,
        "name": "Im Student",
        "country": null,
        "phone": null,
        "language": null,
        "birthday": null,
        "isActivated": false,
        "createdAt": "2021-03-20T15:34:02.066Z",
        "updatedAt": "2021-03-20T15:34:02.066Z",
        "deletedAt": null
    }
}
 *
 */
/**
 * @api {post} /user/feedbackTutor Give feedback for tutor
 * @apiName feedbackTutor
 * @apiGroup User
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 * @apiParam {String} tutorId Id of tutor
 * @apiParam {Number} rating Point rating
 * @apiParam {String} content Content of feedback
 *
* @apiParamExample {json} Request Body Example:
{
    "tutorId": "f73d0dcf-e420-4828-ba36-93d33625a870",
    "rating": 5,
    "content": "content of feedback"
}
 * @apiSuccessExample Success Response Example:
{
    "message": "Feedback success",
    "data": {
        "id": "3d544f44-fbc5-4e9a-85a7-332bea232e34",
        "firstId": "18e8afec-887c-418e-b419-d997b8e9cf6f",
        "secondId": "f73d0dcf-e420-4828-ba36-93d33625a870",
        "content": "content of feedback",
        "rating": 5,
        "updatedAt": "2021-03-22T16:03:09.192Z",
        "createdAt": "2021-03-22T16:03:09.192Z"
    }
}
 *
 */
