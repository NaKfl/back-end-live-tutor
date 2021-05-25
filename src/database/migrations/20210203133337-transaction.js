'use strict';
module.exports = {
  up: async (queryInterface, Sequelize) => {
    await queryInterface.createTable('Transactions', {
      id: {
        allowNull: false,
        autoIncrement: false,
        primaryKey: true,
        type: Sequelize.UUID,
      },
      walletId: {
        type: Sequelize.UUID,
        allowNull: false,
        references: {
          model: 'Wallets',
          key: 'id',
        },
      },
      bookingId: {
        type: Sequelize.UUID,
        references: {
          model: 'Bookings',
          key: 'id',
        },
      },
      price: {
        type: Sequelize.BIGINT,
        allowNull: false,
      },
      status: {
        type: Sequelize.STRING,
        defaultValue: false,
      },
      createdAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
      updatedAt: {
        allowNull: false,
        type: Sequelize.DATE,
      },
    });
  },
  down: async (queryInterface) => {
    await queryInterface.dropTable('Transactions');
  },
};
