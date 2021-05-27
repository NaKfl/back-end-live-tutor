'use strict';

const fakeData = require('./fakeData');

const { wallets } = fakeData;

module.exports = {
  up: async (queryInterface) => {
    await queryInterface.bulkInsert(
      'Wallets',
      [
        {
          id: '12e8afec-887c-418e-b419-d997b8e9cf6f',
          userId: '18e8afec-887c-418e-b419-d997b8e9cf6f',
          amount: 0,
          isBlocked: false,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        {
          id: '4e85658f-48c7-4128-b0c7-1862d663a04f',
          userId: '4e85658f-48c7-4128-b0c7-1862d663a0d3',
          amount: 0,
          isBlocked: false,
          createdAt: new Date(),
          updatedAt: new Date(),
        },
        ...wallets,
      ],
      {},
    );
  },

  down: async (queryInterface) => {
    await queryInterface.bulkDelete('Wallets', null, {});
  },
};
