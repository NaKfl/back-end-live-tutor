'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class FeeTutor extends Model {
    static associate(models) {
      this.belongsTo(models.User, { foreignKey: 'tutorId', as: 'fee' });
    }
  }

  FeeTutor.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      tutorId: {
        allowNull: false,
        type: DataTypes.UUID,
        references: {
          model: 'User',
          key: 'id',
        },
      },
      price: {
        allowNull: false,
        type: DataTypes.BIGINT,
      },
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'FeeTutor',
    },
  );

  return FeeTutor;
};
