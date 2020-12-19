'use strict';

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'Roles',
      [
        {
          id: '77f339bf-d76d-4154-a696-0fda12ed12f3',
          name: 'student',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: 'd7b699a7-ce6e-4c81-8ad4-7aa08ce5a035',
          name: 'tutor',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: '81e3ae2a-1357-4289-9e4f-dd18f8a1e1d0',
          name: 'admin',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Roles', null, {});
  },
};
