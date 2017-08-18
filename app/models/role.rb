class Role < ActiveRecord::Base
  ROLE_TYPES = { 'Admin' => :admin, 'Read-Only' => :user }
end