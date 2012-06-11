module Spice
  class Mock
    class << self
      def setup_mock_client
        self.setup_authentication
        Spice.server_url = 'http://localhost:4000'
        Spice.client_name = "testclient"
        Spice.key_file = "/tmp/keyfile.pem"
        Spice.chef_version = "0.10.4"
      end

      def setup_authentication
        File.open("/tmp/keyfile.pem","w+") do |f|
          f.write(%Q{-----BEGIN RSA PRIVATE KEY-----
MIIEowIBAAKCAQEAqd1K3siOLkxiU0B98QzP+qbT3uPaCIGGR+EAO8mXMpTUNfPv
Kr4NeIV8kqfrngghYF3Y2Ky0e3Ifl3b7UQTfrSofmyoC/EBBA4dH2ygUoYtP0aIi
sdxnSpYhX9PXavZ4POkDuO3SKRUEuC71OzIQQ3GijXA8L1JRBTOb0QiC7vBSuwaM
15qAqW4FGs7jYyG909AERY3AQTmZZ8TsAY07fqv4BC8a6965dzBp3GD5KY/IuRlN
hoqp1xQdqZ8C0nNk6akWoia9/NMs4rULpuiPSeVOSDX0iGcOMFG6Ur5ihBl8S+Dy
96QpNU3Xx/puhALbGxPkoyELwmhuZRmpMo3YDQIDAQABAoIBABYifAsj30MxOO7Y
TJEItmFXM+yrjFHnbvQW4czorAcvVafiLZxIP8Egw+bocs+ZB6BjGkrB1pLvgCZg
nscj93G9N3kktFbimJY5Hqf0RRv352LN2e+LZPpXLeoq1LtferOVOaLzeptX3dGS
bOpVz8C6IhCEO5N/Coe+/eLzVPyFpibhlNpQPPUbPP8mpL2d0oro4GHcO0lcdm0t
5iAs7drwOcA97dntBZFwMj5tA0d6ujgc88lS3eNqZAx5TsOKh+yetNMpO+GJlXFO
koiJ4ZF6Fx6/5R+iX+ejtebA3GPdPAHSMxmVUGWDOeRTdpsqsEyDXsLADb1FTVnk
B4WPvRECgYEA1GkyU2CUw3kcKAQrxfmGdDuTbwSG7/Np9nCie57PDE16CQd6BP5H
cRbOoC10/h2gJmaqODV7PJmeimOd5C74xiLfZ8TZvg+nv2NOwbGMLbU9PiZcjda9
YEVmya6UpMBZdD73yir5PUPHiws3Xx0+8CKpD/nfDhfOVPTIzrJyDMMCgYEAzLj0
2NLWhI17KxNpFV76XlEHmwwhKKCN0HsFj/qSmPQZsRn5Xph9wgH2ey+ag12IOVGe
kbYPz1/74uzfkZpye4ysn1cvDUXbPbAzdBJ8VT/kmQpB1+ZRFRi7xUf+AEp54932
FObLehFPo+w0SKNHeJqKY0k/k/0/AwpapLwVeu8CgYEAh8nYSkTr1SqPPWWtNhqW
Qaf0UHxsZukNTGYk+TJE2nCNG0iUUKzdrwYNgYiNygXWY7YuC1DlP5BVMdMNFNqS
XtfcSdImAMKxUkCCEIEYRAAg7qJHeMVWuzyiwTvB+rCcfxvh/HQMcYXrApBhDYT8
vzbpLTVnyvKdDOKPnNOm5VECgYBajhGX+yLyfRaXRj28O0fqAlOn7KSaMPKp3lDm
kALab1cR9JhOlItEDtQ1RyhEpVHFcOoAMBUsOJvVk8uMv1GWfvI4hTsF1vmUfuUz
mZ2vo9R9MYFQe8sv1sHwENk0zby+44afVjt5IkElFC1IWBkcKte99T+POXzu3lyb
86pYtwKBgEaeHGw4mSbnz6aecPbshGYrV3CkPRO9z6nAiC6lp6a0PYJAPNDrvqdg
5h0uCkb5FfgWIOq2tCUYY/ZrSglE17wPmd8iRAN7wb+prKAHOh+o4P0k1EtviNdU
8JgshucQzoeIygNfo2QG3vfsfA/4V9aa/yb/bqHPsJHBgnuSVjv+
-----END RSA PRIVATE KEY-----})
        end
      end
    end
  end
end