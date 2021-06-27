'use strict';

const fakeData = require('./fakeData');

const { tutorInfo } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'Tutors',
      [
        ...tutorInfo,
        {
          id: '6f9e9b24-7502-4486-ae04-5c368cf181ce',
          userId: '4e85658f-48c7-4128-b0c7-1862d663a0d3',
          isActivated: true,
          accent: 'consequuntur repellendus et',
          bio:
            'Inventore est minus sed fuga ipsam voluptate cupiditate eos cupiditate.',
          education:
            'Necessitatibus adipisci nisi totam. Aliquam dicta exercitationem nobis quae dolorem unde ipsum ad. Minima esse aperiam voluptatem. Magni delectus qui quas suscipit corporis repudiandae placeat et.',
          experience:
            'Minus dolores quasi perspiciatis eveniet ut. Necessitatibus quia excepturi. Corporis consequatur eos nihil temporibus eum aspernatur esse expedita nesciunt. Debitis modi accusamus et enim exercitationem.',
          interests:
            'Quasi nulla porro rem nam delectus blanditiis laboriosam laudantium. Sapiente quibusdam et autem iste minima illum illum cupiditate. Debitis debitis voluptatem inventore eos pariatur. Sit deleniti nihil aut porro quos veritatis. Possimus eum dicta dolores repellendus voluptatem. Ut ut fugiat et ut officia.',
          languages: 'est,non,odit',
          profession: 'quaerat sunt architecto',
          resume:
            'Eos alias nisi repudiandae sit molestias. Ab totam aut voluptas quia ut. Ex doloremque dolor nisi repudiandae voluptatem rem in explicabo. Dignissimos architecto ut aliquam ipsum eius. Iste qui enim.',
          specialties: 'in, tenetur',
          targetStudent: 'nisi sed modi',
          video: 'https://alexandrine.net',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Tutors', null, {});
  },
};
