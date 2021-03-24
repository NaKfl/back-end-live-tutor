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

/**
 * @api {get} /user/favoriteTutor Get list favorite tutor
 * @apiName favoriteTutor
 * @apiGroup User
 * @apiPermission Member
 *
 * @apiHeader {String} Authorization Access token
 *
 * @apiSuccessExample Success Response Example:
{
    [
        {
            "id": "f744f9af-e8a1-464c-b5b2-d3e83eea7b8e",
            "firstId": "13fd5b24-ff38-4a78-af9b-1d794c71e0f1",
            "secondId": "f78059fb-c86c-4526-a2a5-1e9624ed83f7",
            "createdAt": "2021-03-20T04:23:13.926Z",
            "updatedAt": "2021-03-20T04:23:13.926Z",
            "secondInfo": {
                "email": "Clint.Weber@yahoo.com",
                "google": null,
                "facebook": null,
                "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
                "name": "Arjun Glover",
                "country": "Virgin Islands, British",
                "phone": "1-451-949-6382",
                "language": "totam est neque",
                "birthday": "2020-04-27 22:21:55.277 +00:00",
                "isActivated": false,
                "createdAt": "2021-03-20T04:22:01.246Z",
                "updatedAt": "2021-03-20T04:22:01.246Z",
                "deletedAt": null,
                "tutorInfo": {
                    "id": "b4ff4e9c-bcd6-4bb1-b847-6e4c5880e2c7",
                    "userId": "f78059fb-c86c-4526-a2a5-1e9624ed83f7",
                    "video": "http://gerardo.org",
                    "bio": "Cumque dignissimos amet qui.",
                    "education": "Earum perspiciatis eius voluptatem harum rerum quod accusantium. Ea rem ut quod debitis ut. Qui totam velit incidunt impedit occaecati nulla ipsum quaerat eligendi. Error porro at recusandae accusantium consequatur laborum molestias minima. Maxime id tenetur rerum commodi impedit nam. Magnam officiis debitis iste consequuntur consequatur quas labore rerum.",
                    "experience": "Sed eos quaerat omnis. Nobis saepe voluptatem sint et. Qui odio officia doloremque. Debitis unde tempora sed at nesciunt voluptatem. Et mollitia et ea.",
                    "profession": "nulla ipsum autem",
                    "accent": "quia tenetur doloribus",
                    "targetStudent": "fuga est rerum",
                    "interests": "Magnam voluptatem sint excepturi. Aliquam atque ratione sed quibusdam fugiat. Officia doloribus dignissimos ut consequatur ipsa et nam dolorum qui. Qui atque expedita est consequuntur officiis sint. Architecto voluptas perspiciatis quae. Quam corrupti cupiditate fugit sed.",
                    "languages": [
                        "officiis"
                    ],
                    "specialties": [
                        "omnis",
                        "quas",
                        "officiis",
                        "quidem",
                        "aspernatur"
                    ],
                    "resume": "Nihil est libero autem quo sed exercitationem rerum nostrum. Aut ut ex recusandae omnis. Repudiandae fugit quia ea sit rem aut. Est quisquam architecto et. Aperiam est ipsum voluptatem soluta soluta. Atque sint iusto eaque non inventore.",
                    "isActivated": true,
                    "createdAt": "2021-03-20T04:22:01.267Z",
                    "updatedAt": "2021-03-20T04:22:01.267Z"
                }
            }
        },
        {
            "id": "fc506abd-7015-4a8c-aab5-c893089b3f23",
            "firstId": "13fd5b24-ff38-4a78-af9b-1d794c71e0f1",
            "secondId": "3a00db85-ec8e-4e2b-ac55-0612565a6753",
            "createdAt": "2021-03-20T04:23:03.630Z",
            "updatedAt": "2021-03-20T04:23:03.630Z",
            "secondInfo": {
                "email": "Paige71@yahoo.com",
                "google": null,
                "facebook": null,
                "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
                "name": "Jordan Bins",
                "country": "Latvia",
                "phone": "210-675-1841 x0963",
                "language": "totam maxime aut",
                "birthday": "2020-11-03 07:09:02.825 +00:00",
                "isActivated": false,
                "createdAt": "2021-03-20T04:22:01.246Z",
                "updatedAt": "2021-03-20T04:22:01.246Z",
                "deletedAt": null,
                "tutorInfo": {
                    "id": "ad46dd4c-db03-4d98-a1e6-bd51fb2facac",
                    "userId": "3a00db85-ec8e-4e2b-ac55-0612565a6753",
                    "video": "https://perry.net",
                    "bio": "Consequatur magni ut et libero sint in consectetur omnis.",
                    "education": "Voluptas sit et fuga repellendus natus quos quis ut qui. Tenetur vero natus et dolor et. Laboriosam dolores in consequatur voluptate libero neque dicta perferendis quos.",
                    "experience": "Fugiat natus blanditiis vel ad soluta. Debitis iusto et qui doloremque tempore facilis. Tempore laudantium eveniet et impedit velit consequatur ut deserunt id.",
                    "profession": "quaerat numquam nisi",
                    "accent": "sint quod nemo",
                    "targetStudent": "quo possimus sit",
                    "interests": "Delectus consectetur a architecto accusantium molestiae rerum. Facilis nam debitis natus doloremque. Totam iste incidunt est est asperiores itaque nisi. Est repellat ex accusamus fugiat occaecati consequatur. Molestiae quaerat ducimus iusto qui unde maxime. Blanditiis ex ut quibusdam est at et et magnam vel.",
                    "languages": [
                        "saepe",
                        "a",
                        "veniam",
                        "quis"
                    ],
                    "specialties": [
                        "laboriosam"
                    ],
                    "resume": "Aut laboriosam error voluptate sunt quia eaque adipisci eos et. Vitae dolore quae aliquid aut perspiciatis dolorem tenetur. Fugit laudantium quibusdam dignissimos voluptatibus provident. Non nesciunt et aperiam officiis velit molestiae quam. Dolorem nesciunt eligendi cumque laboriosam soluta commodi pariatur consequatur. Fuga est molestias est corporis enim tempore voluptas ratione soluta.",
                    "isActivated": true,
                    "createdAt": "2021-03-20T04:22:01.267Z",
                    "updatedAt": "2021-03-20T04:22:01.267Z"
                }
            }
        }
    ]
}
 */

/**
/**
 * @api {post} /user/manageFavoriteTutor Add/remove favorite tutor
 * @apiName manageFavoriteTutor
 * @apiGroup User
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 * @apiParam {String} tutorId Id of tutor
 *
 * @apiParamExample Request Param Example:
    {
        "tutorId":"3a00db85-ec8e-4e2b-ac55-0612565a6753"
    }
 *
 * @apiSuccessExample Success Response Example:
    {
        "message": "Manage success",
        "result": 1
    }
 *
 */
/**
 * @api {post} /user/uploadAvatar Upload avatar
 * @apiName uploadAvatar
 * @apiGroup User
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 * @apiParam {File} avatar File image of avatar
 *
 * @apiParamExample Request Param Example:
    {
        "avatar":"file"
    }
 *
 * @apiSuccessExample Success Response Example:
    {
        "message": "Manage success",
        "result": 1
    }
 *
 */
