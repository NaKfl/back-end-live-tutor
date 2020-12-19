'use strict';

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'UserRoles',
      [
        {
          userId: '18e8afec-887c-418e-b419-d997b8e9cf6f',
          roleId: '77f339bf-d76d-4154-a696-0fda12ed12f3',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          userId: '4e85658f-48c7-4128-b0c7-1862d663a0d3',
          roleId: 'd7b699a7-ce6e-4c81-8ad4-7aa08ce5a035',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          userId: '6f807670-2175-46b9-87f5-23925f30405e',
          roleId: '81e3ae2a-1357-4289-9e4f-dd18f8a1e1d0',
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('UserRoles', null, {});
  },
};
