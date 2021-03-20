class User {
  constructor({ id, name, email, avatar }) {
    this.id = id;
    this.name = name;
    this.email = email;
    this.avatar = avatar;
    this.status = 'ONLINE';
    this.sockets = [];
  }
}

export default User;
