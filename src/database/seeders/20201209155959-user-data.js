'use strict';

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'Users',
      [
        {
          id: '18e8afec-887c-418e-b419-d997b8e9cf6f',
          email: 'student@gmail.com',
          password:
            '$2a$12$VvWghIAnvkFgVG1hZ6OGyeaDtEPKGxZYmEu9PExiuke2WCDS5Fywe',
          name: 'Im Student',
          isDeleted: false,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: '4e85658f-48c7-4128-b0c7-1862d663a0d3',
          email: 'tutor@gmail.com',
          password:
            '$2a$12$VvWghIAnvkFgVG1hZ6OGyeaDtEPKGxZYmEu9PExiuke2WCDS5Fywe',
          name: 'Im Tutor',
          isDeleted: false,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: '6f807670-2175-46b9-87f5-23925f30405e',
          email: 'admin@gmail.com',
          password:
            '$2a$12$VvWghIAnvkFgVG1hZ6OGyeaDtEPKGxZYmEu9PExiuke2WCDS5Fywe',
          name: 'Im Admin',
          isDeleted: false,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
      ],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Users', null, {});
  },
};
