'use strict';

const { Model } = require('sequelize');

module.exports = (sequelize, DataTypes) => {
  class Role extends Model {
    // static associate(models) {}
  }

  Role.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      name: DataTypes.STRING,
    },
    {
      sequelize,
      modelName: 'Role',
    },
  );

  return Role;
};
