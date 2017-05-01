class CreateRolesService
  def call
    roles = []
    role = Role.create!(name: 'admin') #create and assign admin role
    ap "ROLE: #{role.inspect}"
    roles << role
    role = Role.create!(name: 'editor') #create and assign editor role
    ap "ROLE: #{role.inspect}"
    roles << role
    role = Role.create!(name: 'user') #cerate and assign user role
    ap "ROLE: #{role.inspect}"
    roles << role
  end
end