'use strict';

const fakeDate = require('./fakeData');

const { roleIds } = fakeDate;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'Roles',
      [
        {
          id: roleIds.student,
          name: 'student',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: roleIds.tutor,
          name: 'tutor',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: roleIds.admin,
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
