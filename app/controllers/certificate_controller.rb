class CertificateController < ApplicationController

  def create
    key = OpenSSL::PKey::RSA.new 2048
    ca = OpenSSL::X509::Name.parse("/givenName=#{params[:nome]}/2.16.76.1.3.1=#{params[:cpf]}/emailAddress=#{params[:email]}")
    cert = OpenSSL::X509::Certificate.new
    cert.version = 2
    cert.serial = 2
    cert.subject = ca
    cert.issuer = ca
    cert.public_key = key.public_key
    cert.not_before = Time.now
    cert.not_after = cert.not_before + 365 * 24 * 60 * 60 # 1 years validity
    cert.sign(key, OpenSSL::Digest::SHA256.new)
    @cert = cert
    @key = key
    puts cert.public_key
    puts key.public_key
  end

  def sign
    key = OpenSSL::PKey::RSA.new params[:key]
    send_data key.sign(OpenSSL::Digest::SHA256.new, params[:documento]), filename: "documento"
  end

  def verify
    cert2 = OpenSSL::X509::Certificate.new params[:cert]
    
    signature = params[:signature].read

    if cert2.public_key.verify(OpenSSL::Digest::SHA256.new, signature, params[:documento])
      @response = "Assinatura Válida"
    else
      @response = "Assinatura Inválida"
    end
  end

  def auth
    cert2 = OpenSSL::X509::Certificate.new params[:cert]
    key = OpenSSL::PKey::RSA.new params[:key]
    puts key.public_key.to_s
    puts cert2.public_key.to_s

    if cert2.public_key.to_s == key.public_key.to_s
      @response = "Certificado Válido"
    else
      @response = "Certificado Inválido"
    end
  end
end
