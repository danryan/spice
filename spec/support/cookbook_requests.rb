def stub_cookbook_list
  stub_request(:get, "http://localhost:4000/cookbooks").
  to_return(
    :status => 200,
    :body => "[\"unicorn\",\"apache2\"]",
    :headers => {})
end

def stub_cookbook_show(name, status=200)
  case status
  when 200
    stub_request(:get, "http://localhost:4000/cookbooks/#{name}").
      to_return(
        :status => status,
        :body => %Q{{
          "#{name}": [
            "0.1.2"
          ]
        }}
      )
  when 404
    stub_request(:get, "http://localhost:4000/cookbooks/#{name}").
    to_return(
      :status => status,
      :body => "{\"error\":[\"Cannot load cookbook #{name}\"]}")
  end
end


# TODO: stub /cookbooks/COOKBOOK_NAME/COOKBOOK_VERSION

def stub_cookbook_update(name, status=200)
  case status
  when 200
    stub_request(:put, "http://localhost:4000/cookbooks/#{name}").
      with(:body => update_cookbook_payload).
      to_return(
        :status => status,
        :body => %Q{{#{"\"private_key\":\"RSA PRIVATE KEY\"," if private_key}\"admin\": true}
        }
      )
  # when 404
  #     stub_request(:get, "http://localhost:4000/cookbooks/#{name}").
  #     to_return(
  #       :status => status,
  #       :body => "{\"error\":[\"Cannot load cookbook #{name}\"]}")
  end
end

def stub_cookbook_delete(name, status=200)
  case status
  when 200
    stub_request(:delete, "http://localhost:4000/cookbooks/#{name}").
      with(:body => "").
      to_return(
        :status => status,
        :body => ""
      )
  when 404
    stub_request(:delete, "http://localhost:4000/cookbooks/#{name}").
      with(:body => "").
      to_return(
        :status => status,
        :body => "{\"error\":[\"Cannot load cookbook sasdasdf\"]}"
      )
  end
end

update_cookbook_payload = %Q{
{
  "definitions": [
    {
      "name": "unicorn_config.rb",
      "checksum": "c92b659171552e896074caa58dada0c2",
      "path": "definitions/unicorn_config.rb",
      "specificity": "default"
    }
  ],
  "name": "unicorn-0.1.2",
  "attributes": [

  ],
  "files": [

  ],
  "json_class": "Chef::CookbookVersion",
  "providers": [

  ],
  "metadata": {
    "dependencies": {
      "ruby": [

      ],
      "rubygems": [

      ]
    },
    "name": "unicorn",
    "maintainer_email": "ops@opscode.com",
    "attributes": {
    },
    "license": "Apache 2.0",
    "suggestions": {
    },
    "platforms": {
    },
    "maintainer": "Opscode, Inc",
    "long_description": "= LICENSE AND AUTHOR:\n\nAuthor:: Adam Jacob <adam@opscode.com>\n\nCopyright 2009-2010, Opscode, Inc.\n\nLicensed under the Apache License, Version 2.0 (the \"License\");\nyou may not use this file except in compliance with the License.\nYou may obtain a copy of the License at\n\n    http://www.apache.org/licenses/LICENSE-2.0\n\nUnless required by applicable law or agreed to in writing, software\ndistributed under the License is distributed on an \"AS IS\" BASIS,\nWITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.\nSee the License for the specific language governing permissions and\nlimitations under the License.\n",
    "recommendations": {
    },
    "version": "0.1.2",
    "conflicting": {
    },
    "recipes": {
      "unicorn": "Installs unicorn rubygem"
    },
    "groupings": {
    },
    "replacing": {
    },
    "description": "Installs/Configures unicorn",
    "providing": {
    }
  },
  "libraries": [

  ],
  "templates": [
    {
      "name": "unicorn.rb.erb",
      "checksum": "36a1cc1b225708db96d48026c3f624b2",
      "path": "templates/default/unicorn.rb.erb",
      "specificity": "default"
    }
  ],
  "resources": [

  ],
  "cookbook_name": "unicorn",
  "version": "0.1.2",
  "recipes": [
    {
      "name": "default.rb",
      "checksum": "ba0dadcbca26710a521e0e3160cc5e20",
      "path": "recipes/default.rb",
      "specificity": "default"
    }
  ],
  "root_files": [
    {
      "name": "README.rdoc",
      "checksum": "d18c630c8a68ffa4852d13214d0525a6",
      "path": "README.rdoc",
      "specificity": "default"
    },
    {
      "name": "metadata.rb",
      "checksum": "967087a09f48f234028d3aa27a094882",
      "path": "metadata.rb",
      "specificity": "default"
    },
    {
      "name": "metadata.json",
      "checksum": "45b27c78955f6a738d2d42d88056c57c",
      "path": "metadata.json",
      "specificity": "default"
    }
  ],
  "chef_type": "cookbook_version"
} 
}