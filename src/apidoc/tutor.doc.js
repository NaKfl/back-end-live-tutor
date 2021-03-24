/**
/**
 * @api {get} /tutor Get list of tutor
 * @apiName login
 * @apiGroup Tutor
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 * @apiParam {Number} [page=1] Index of page
 * @apiParam {Number} [perPage=20] Pages per page
 * @apiParam {String} [search] Search by name
 *
 * @apiParamExample Request Param Example:
/tutor?page=1&perPage=2
 *
 * @apiSuccessExample Success Response Example:
{
    "tutors": {
        "count": 50,
        "rows": [
            {
                "email": "Alysa86@gmail.com",
                "google": null,
                "facebook": null,
                "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
                "name": "Humberto Gulgowski",
                "country": "Brunei Darussalam",
                "phone": "1-842-254-7453",
                "language": "itaque voluptatem tempore",
                "birthday": "2020-05-04 13:50:06.899 +00:00",
                "isActivated": true,
                "createdAt": "2021-03-21T11:24:58.270Z",
                "updatedAt": "2021-03-21T11:24:58.270Z",
                "deletedAt": null,
                "feedbacks": [],
                "id": "97e9bc90-20dd-4956-aa31-2be5ed50d79e",
                "userId": "205a3a59-0280-4879-9e93-611e637c5843",
                "video": "http://rodger.info",
                "bio": "Dolor qui cupiditate.",
                "education": "Voluptatem expedita nobis tenetur quia. Voluptas vitae ut. Illo quo rerum. Magnam consequatur aut.",
                "experience": "Aut at unde est ipsa nulla optio. Id voluptatem nostrum occaecati et et quibusdam quod ab. Sed mollitia dolores eaque et.",
                "profession": "pariatur et optio",
                "accent": "soluta beatae ut",
                "targetStudent": "sint et consequuntur",
                "interests": "Amet facilis sit. Aut et officiis exercitationem saepe earum cum. At esse laboriosam non.",
                "languages": [
                    "similique"
                ],
                "specialties": [
                    "quibusdam"
                ],
                "resume": "Velit repellendus soluta est officia voluptatem. Ut et quam. Aut facilis omnis et iure harum ducimus libero tenetur error. Sint maxime sed illum reiciendis molestiae. Quaerat aliquid quia et blanditiis vitae ut dicta."
            },
            {
                "email": "Pietro.Waters76@yahoo.com",
                "google": null,
                "facebook": null,
                "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
                "name": "Laura Medhurst",
                "country": "Peru",
                "phone": "339.493.9513 x124",
                "language": "hic sit quia",
                "birthday": "2021-02-15 11:38:27.227 +00:00",
                "isActivated": true,
                "createdAt": "2021-03-21T11:24:58.270Z",
                "updatedAt": "2021-03-21T11:24:58.270Z",
                "deletedAt": null,
                "feedbacks": [],
                "id": "95767799-bf86-462d-9e26-eea5fec4a483",
                "userId": "7b4dbc83-78aa-402f-98e1-ca57414f44ad",
                "video": "http://christopher.net",
                "bio": "Beatae cum non.",
                "education": "Repellendus reprehenderit doloribus sequi veniam corrupti. Voluptatem sint ullam ut eaque. Debitis iste voluptatem eos perspiciatis sit consectetur quia saepe quis. Ea ut qui est nam minus voluptatem omnis. Soluta perferendis explicabo. Maiores distinctio nostrum.",
                "experience": "Quia a quis distinctio molestiae quia quo. Magnam quam odio ut repudiandae dolorum doloremque illo consequatur. Et alias voluptatum eum nisi incidunt. Ut voluptate molestiae natus consequatur omnis harum velit qui. Eos accusantium aut ut et aliquid et.",
                "profession": "consequatur corporis officiis",
                "accent": "dolore nisi aliquam",
                "targetStudent": "sequi unde quia",
                "interests": "Eligendi qui quia. Est corporis itaque aut omnis distinctio quia. Odit et perspiciatis eum est incidunt possimus quod est nihil. Beatae autem quo voluptas voluptatem et. Sed quia quo voluptatum et ea exercitationem. Illum dolores saepe dolor quis.",
                "languages": [
                    "corrupti",
                    "culpa"
                ],
                "specialties": [
                    "autem",
                    "corrupti"
                ],
                "resume": "Tenetur necessitatibus quisquam similique et aspernatur. Dignissimos voluptatem sed neque. Accusantium magni ipsam dignissimos libero et dolor illo labore. Quaerat facere aperiam exercitationem ex molestias et maiores. Distinctio eum fuga rerum. Nihil iusto repudiandae ut."
            }
        ]
    },
    "favoriteTutor": []
}
 *
 */

/**
 * @api {get} /tutor/:id Get detail of tutor
 * @apiName detail
 * @apiGroup Tutor
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 *
 * @apiParamExample Request Param Example:
/tutor/80a20249-f7f3-4c8c-9639-73ced94edae4
 *
 * @apiSuccessExample Success Response Example:
{
    "id": "005b331d-1e6f-4a4e-8b84-73eb58b3ce0c",
    "userId": "80a20249-f7f3-4c8c-9639-73ced94edae4",
    "video": "https://miller.name",
    "bio": "Eius ut ut est.",
    "education": "Qui aut ad natus molestiae reprehenderit et architecto dolorum dolores. Nemo est et saepe atque reiciendis distinctio. Voluptatem aliquid sit consequatur sapiente harum necessitatibus sit aut dolore.",
    "experience": "Qui eaque tempore. Consectetur aut quia et aut ipsam ex est. Rem rem hic est et eos quibusdam qui harum. Et odio voluptas ad eos nobis reiciendis saepe facilis quaerat. Quaerat maiores soluta voluptatum quis at dolorum. In soluta quod labore at non.",
    "profession": "enim laboriosam assumenda",
    "accent": "id accusamus nostrum",
    "targetStudent": "laboriosam non voluptate",
    "interests": "Commodi qui quaerat et dolores cupiditate enim non ipsa nam. Repellendus ex voluptatem illum iure nesciunt. Rerum non fuga itaque quos minima sunt. Architecto omnis nihil. Atque nam amet odit perspiciatis officiis. Temporibus voluptates dolores et illo eum.",
    "languages": [
        "aut",
        "velit",
        "magnam",
        "voluptatibus"
    ],
    "specialties": [
        "quia"
    ],
    "resume": "Illo nemo numquam. Vero animi qui voluptatum. In odio fugit architecto ab accusamus earum. Non dolor consequatur ea ut nihil voluptate laudantium. Sequi vero sed eos iste illo quia.",
    "isActivated": true,
    "createdAt": "2021-03-20T15:34:02.039Z",
    "updatedAt": "2021-03-20T15:34:02.039Z",
    "User": {
        "email": "Haylie.Bartell21@hotmail.com",
        "google": null,
        "facebook": null,
        "avatar": "https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png",
        "name": "Howell Hilpert",
        "country": "Virgin Islands, British",
        "phone": "859.492.0839",
        "language": "rerum at reiciendis",
        "birthday": "2020-05-09 07:38:55.917 +00:00",
        "isActivated": false,
        "createdAt": "2021-03-20T15:34:02.027Z",
        "updatedAt": "2021-03-20T15:34:02.027Z",
        "deletedAt": null,
        "feedbacks": []
    },
    "isFavorite": false
}
 *
 */

/**
 * @api {get} /tutor/register Register tutor
 * @apiName register
 * @apiGroup Tutor
 *
 * @apiPermission Member
 * @apiHeader {String} Authorization Access token
 * @apiParam {String} name Name of Tutor
 * @apiParam {String} country Country of Tutor
 * @apiParam {Date} birthday Birthday
 * @apiParam {String} interests Interests
 * @apiParam {String} education Education
 * @apiParam {String} experience Experience
 * @apiParam {String} profession Profession
 * @apiParam {String} languages Languages
 * @apiParam {String} accent Accent
 * @apiParam {String} bio Biography
 * @apiParam {File} avatar Avatar
 * @apiParam {File} video Video introduction's Tutor
 * @apiParamExample Request Body Example:
{
    "name":"Hoai Bao"
    "country":"VietNam"
    "birthday":"2000/12/12"
    "interests":"Travel"
    "education":"Dai hoc"
    "experience":"None"
    "profession":"none"
    "languages":"English"
    "accent":"North America"
    "bio":"I'm doctor"
    "targetStudent":"Intermediate"
    "specialties":"Business English,Grammar instruction",
    "avatar":"ImageFile",
    "avatar":"VideoFile"
}
 *
 * @apiSuccessExample Success Response Example:
{
    "id": "8eb7cec7-36e6-4189-8a95-3c82e3aced7d",
    "isActivated": false,
    "interests": "Travel",
    "education": "Dai hoc",
    "experience": "None",
    "profession": "none",
    "accent": "North America",
    "bio": "I'm doctor",
    "targetStudent": "Intermediate",
    "languages": [
        "English"
    ],
    "specialties": [
        "Business English,Grammar instruction"
    ],
    "video": "http://localhost:5000/video/13fd5b24-ff38-4a78-af9b-1d794c71e0f1video.mov",
    "userId": "13fd5b24-ff38-4a78-af9b-1d794c71e0f1",
    "updatedAt": "2021-03-23T18:11:20.987Z",
    "createdAt": "2021-03-23T18:11:20.987Z",
    "resume": null
}
 *
 * @apiErrorExample Error: User have already been a tutor
{
    "statusCode": 500,
    "message": "User have already been a tutor"
}
 *
 */
