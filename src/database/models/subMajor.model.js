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
      key: DataTypes.STRING,
      englishName: DataTypes.TEXT,
      vietnameseName: DataTypes.TEXT,
      createdAt: DataTypes.DATE,
      updatedAt: DataTypes.DATE,
    },
    {
      sequelize,
      modelName: 'SubMajor',
    },
  );
  return SubMajor;
};
