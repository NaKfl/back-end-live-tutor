'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class Fee extends Model {
    static associate(models) {}
  }
  Fee.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      key: DataTypes.STRING,
      price: DataTypes.BIGINT,
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'Fee',
    },
  );
  return Fee;
};
