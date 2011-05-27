require "digest/md5"
class Profile < ActiveRecord::Base
  has_many :ProfileUrls
  has_one :Organization
  after_create :create_Organization

  def self.add
    rec = self.new
    rec.save

    time = Time.new
    i = 1
    uid = ""
    begin 
      uid = Digest::MD5.hexdigest("--#{time.inspect}#--#{rec.id}--#{i}")
    end while not self.find_by_uid(uid).nil?
    rec.uid = uid
    rec.save
    rec
  end

  def pass
    Digest::MD5.hexdigest("#{uid}installation-password")
  end
end
