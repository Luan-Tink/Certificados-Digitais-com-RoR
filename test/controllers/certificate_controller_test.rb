require 'test_helper'

class CertificateControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get certificate_create_url
    assert_response :success
  end

  test "should get sign" do
    get certificate_sign_url
    assert_response :success
  end

  test "should get verify" do
    get certificate_verify_url
    assert_response :success
  end

  test "should get auth" do
    get certificate_auth_url
    assert_response :success
  end

end
