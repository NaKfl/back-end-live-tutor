/**
/**
 * @api {get} /tutor/list/approval Get list of user register tutor
 * @apiName listApproval
 * @apiGroup Admin
 *
 * @apiPermission Admin
 * @apiHeader {String} Authorization Access token
 *
 * @apiParamExample Request Param Example:
/tutor/list/approval
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Success",
    "data": [
        {
            "id": "029c11da-92f4-4761-a6da-05c858a60cb3",
            "userId": "d3d7871f-24fd-4e77-a137-a28bf0b31eb6",
            "video": "http://milo.org",
            "bio": "Nostrum eum reprehenderit.",
            "education": "Ducimus asperiores labore commodi. Ad neque molestias numquam eum voluptas impedit. Nostrum consequuntur id deleniti. Cumque ut earum porro.",
            "experience": "Consequatur quos corrupti quidem sed hic doloremque accusamus. Aspernatur veniam magnam quasi alias quo animi tenetur nisi. Tempora ut deleniti et repellendus quas. In aut numquam. Est deserunt impedit.",
            "profession": "asperiores id voluptatem",
            "accent": "quae unde quas",
            "targetStudent": "voluptates harum illo",
            "interests": "Dolorum consequuntur sit repellat est magni asperiores et. Voluptatem quibusdam aliquam ut laboriosam vitae voluptatem. Assumenda consequatur numquam nobis. Est officia non suscipit asperiores modi dolore laudantium est expedita. Explicabo at in quia voluptatem facilis. Odit perspiciatis ut.",
            "languages": [
                "eveniet",
                "consequuntur",
                "ut",
                "ipsum"
            ],
            "specialties": [
                "velit",
                "tempore",
                "minima",
                "recusandae",
                "et"
            ],
            "resume": "Illo ducimus voluptas aut quod labore. Sint at aut perferendis at consequatur. Quod illo aut sequi perspiciatis. Consequatur vero sit quis. Corporis illo sed alias nisi ut.",
            "isActivated": false,
            "createdAt": "2021-03-20T15:34:02.036Z",
            "updatedAt": "2021-03-20T15:34:02.036Z",
            "User": {
                "email": "Conor.Zieme@gmail.com",
                "google": null,
                "facebook": null,
                "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
                "name": "Deron Maggio",
                "country": "Saint Kitts and Nevis",
                "phone": "981.400.1332 x36046",
                "language": "praesentium voluptatibus doloribus",
                "birthday": "2020-07-19 22:18:01.818 +00:00",
                "isActivated": false,
                "createdAt": "2021-03-20T15:34:02.025Z",
                "updatedAt": "2021-03-20T15:34:02.025Z",
                "deletedAt": null
            }
        },
    ]
}
 *
 */

/**
 * @api {put} /tutor/update/approval Approve to register tutor
 * @apiName updateApproval
 * @apiGroup Admin
 *
 * @apiPermission Admin
 * @apiHeader {String} Authorization Access token
 * @apiParam {String} userId Id of user
 * @apiParam {Boolean="true","false"} isActivated Approve/Deny
 *
 * @apiParamExample {json} Request Body Example:
{
    "userId": "f73d0dcf-e420-4828-ba36-93d33625a870",
    "isActivated": true
}
 *
 * @apiSuccessExample Success Response Example:
{
    "message": "Success",
    "data": {
        "id": "053f275d-0c5c-4926-a31e-2613992daa47",
        "userId": "f73d0dcf-e420-4828-ba36-93d33625a870",
        "video": "http://lorenzo.org",
        "bio": "Laborum vero commodi minima incidunt et accusamus earum nihil.",
        "education": "Est non occaecati. Tenetur explicabo et quasi in quod perspiciatis ipsa eius. Excepturi sunt fuga.",
        "experience": "Excepturi voluptatem consequatur numquam pariatur magni ipsa facere. Dolorem fuga omnis accusantium necessitatibus aut magni inventore et. Deserunt debitis ad dolores. Fugit sit autem.",
        "profession": "corrupti aut ut",
        "accent": "odit eveniet quo",
        "targetStudent": "blanditiis architecto sint",
        "interests": "Accusamus qui facilis quaerat illo est. Ducimus quis omnis odio voluptates rerum. Aut explicabo et quia velit.",
        "languages": [
            "vitae"
        ],
        "specialties": [
            "non"
        ],
        "resume": "Tempore tempore ut sed. Aliquid perspiciatis esse deserunt suscipit. Saepe provident tenetur repellat qui vero voluptas debitis quas. Ut nesciunt aut quisquam debitis tempore fuga voluptas. Aliquam natus mollitia consequatur recusandae.",
        "isActivated": true,
        "createdAt": "2021-03-20T15:34:02.040Z",
        "updatedAt": "2021-03-22T15:51:25.484Z",
        "User": {
            "email": "Malvina35@gmail.com",
            "google": null,
            "facebook": null,
            "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
            "name": "Enos Marquardt",
            "country": "Turkmenistan",
            "phone": "1-254-432-2015 x8441",
            "language": "a aliquam veniam",
            "birthday": "2020-11-02 16:40:37.126 +00:00",
            "isActivated": false,
            "createdAt": "2021-03-20T15:34:02.030Z",
            "updatedAt": "2021-03-20T15:34:02.030Z",
            "deletedAt": null,
            "feedbacks": []
        }
    }
}
 *
 */
