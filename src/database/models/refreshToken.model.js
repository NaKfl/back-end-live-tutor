'use strict';

const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class RefreshToken extends Model {
    static associate(models) {
      this.belongsTo(models.User, {
        foreignKey: 'userId',
        as: 'userInfo',
      });
    }
  }

  RefreshToken.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      token: { type: DataTypes.STRING, allowNull: false },
      userId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      userEmail: {
        type: DataTypes.STRING,
        allowNull: false,
      },
      expires: { type: DataTypes.DATE },
    },
    {
      sequelize,
      modelName: 'RefreshToken',
    },
  );

  return RefreshToken;
};
