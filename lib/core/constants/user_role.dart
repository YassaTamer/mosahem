enum UserRole {
  admin,
  volunteer,
  organization,
}

UserRole parseUserRole(String role) {
  switch (role.toLowerCase()) {
    case 'admin':
      return UserRole.admin;
    case 'volunteer':
      return UserRole.volunteer;
    case 'organization':
      return UserRole.organization;
    default:
      throw Exception('Unknown role');
  }
}
