class ProfileSerializer < ActiveModel::Serializer
  attribute :created_tasks do
    ActiveModel::Serializer::CollectionSerializer.new(object.tasks, serializer: TaskSerializer)
  end
  attribute :claimed_tasks do
    ActiveModel::Serializer::CollectionSerializer.new(object.accepted_tasks, serializer: TaskSerializer)
  end
end
