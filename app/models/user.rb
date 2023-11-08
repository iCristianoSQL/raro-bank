class User < ApplicationRecord
  has_one :balance
  has_one :administrator
  has_many :sent_transfers, class_name: "Transfer", foreign_key: "sender_id"
  has_many :received_transfers, class_name: "Transfer", foreign_key: "receiver_id"
  belongs_to :classroom, optional: true
  has_many :classrooms, through: :classroom_users
  has_and_belongs_to_many :investments

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable
  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: true
  validates :cpf, length: { is: 11 }

  after_create :create_balance

  def create_balance
    CreateInitialBalanceService.call(self) unless balance.present?
  end

  def transferable_contacts
    return [] unless sent_transfers.present?

    sent_transfers.map{ |transfer| transfer.receiver }.uniq
  end

  def administrator?
    administrator.present?
  end
end
