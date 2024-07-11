class TaskPolicy < ApplicationPolicy
  class Scope < ApplicationPolicy::Scope
    def resolve
      # Burada `scope` değişkeni üzerinde filtreleme yaparak,
      # kullanıcının kendi görevlerine erişimini sağlıyoruz.
      scope.where(user: user)
    end
  end

  def show?
    # `show?` metodunda, gösterilecek kaydın (`record`) sahibinin
    # mevcut kullanıcı (`user`) olduğunu kontrol ediyoruz.
    record.user == user
  end

  def create?
    # Yeni bir görev oluşturma yetkisi, kullanıcının mevcut olmasına bağlı.
    user.present?
  end

  def update?
    # Bir görevin güncellenmesi yetkisi, sadece görevin sahibi olan
    # kullanıcıya (`record.user`) aittir.
    record.user == user
  end

  def destroy?
    # Bir görevin silinmesi yetkisi, sadece görevin sahibi olan
    # kullanıcıya (`record.user`) aittir.
    record.user == user
  end
end
