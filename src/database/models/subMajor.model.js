'use strict';
const { Model } = require('sequelize');
module.exports = (sequelize, DataTypes) => {
  class SubMajor extends Model {
    static associate(models) {
      this.belongsTo(models.Major, {
        foreignKey: 'majorId',
        as: 'major',
      });
    }
  }
  SubMajor.init(
    {
      id: {
        allowNull: false,
        primaryKey: true,
        type: DataTypes.UUID,
        defaultValue: DataTypes.UUIDV4,
        autoIncrement: false,
      },
      majorId: {
        type: DataTypes.UUID,
        allowNull: false,
        references: {
          model: 'Major',
          key: 'id',
        },
      },
      englishName: DataTypes.TEXT,
      vietnameseName: DataTypes.TEXT,
      createdAt: { type: DataTypes.DATE, defaultValue: new Date() },
      updatedAt: { type: DataTypes.DATE, defaultValue: new Date() },
    },
    {
      sequelize,
      modelName: 'SubMajor',
    },
  );
  return SubMajor;
};
