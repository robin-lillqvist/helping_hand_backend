class ProfileSerializer < ActiveModel::Serializer
  attributes :id, :provider_id, :user_id
  belongs_to :user, serializer: UserSerializer

end
