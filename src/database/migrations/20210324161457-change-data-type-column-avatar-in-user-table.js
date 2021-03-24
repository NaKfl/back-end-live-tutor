'use strict';

module.exports = {
  up: async (queryInterface, Sequelize) => {
    queryInterface.changeColumn('Users', 'avatar', {
      type: Sequelize.DataTypes.TEXT,
      defaultValue:
        'https://www.alliancerehabmed.com/wp-content/uploads/icon-avatar-default.png',
    });
  },

  down: async (queryInterface, Sequelize) => {
    queryInterface.changeColumn('Users', 'avatar', {
      type: Sequelize.DataTypes.STRING,
      defaultValue: null,
    });
  },
};
