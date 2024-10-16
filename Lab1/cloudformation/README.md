## Usage
1. **Cài đặt cfn**: cfn hiện tại chỉ có thể cài đặt trên linux vì vậy nếu bạn sử dụng windows đầu tiên ta cần cài đặt wsl (Đây là Windows Subsystem for Linux)


    Vì ở đây mình sử dụng archlinux cho wsl nên mình cũng sẽ tải cfn trên package của archlinux
      ```
      wsl --install
      
      sudo pacman -S cfn-lint 
      ```
2. **Cấu hình AWS Credentials**: Cài đặt AWS CLI và sử dụng lệnh ```aws configure``` để thêm accesskey và secretkey giúp terraform có thể thực hiện các dịch vụ
3. **Clone Github Project**:
      ```
      git clone https://github.com/pokilee10/NT548.P11.MMCL/tree/main
      cd NT548.P11.MMCL/Lab1/cloudformation/
      ```
4. **Chạy code Cloudformation**:
   
   1. Khởi tạo S3 Bucket (Lưu ý: không thể tạo các S3 Bucket khác nhau nhưng có cùng 1 tên )
      ```
      aws s3api create-bucket --bucket <s3_bucket_name> --region <your_region>
      ```
   2.1 Tạo Keypair
      ```
      aws ec2 create-key-pair --key-name <namekeypair>
      ```
   2.2 Nếu đã có sẵn Keypair đã tạo từ trước ta có thể sử dụng lệnh sau để đưa public lên aws để sử dụng 
      ```
      aws ec2 import-key-pair --key-name <your-key-name-in-aws> --public-key-material file://~/.ssh/<your-public-key>.pub
      ```
    
   3. Thực hiện chỉnh sửa các biến nếu cần thiết trong file ``parameter.yaml`` ip mong muốn có thể ssh vào public instance và key name đã tạo ở trên
    (Nên tìm kiếm What's my IP để lấy IP public cùa máy mình vả đưa vào IP)
      ```
      {
        "ParameterKey": "AllowedSSHIP",
        "ParameterValue": "<your-device-ip>" 
      },
      {
        "ParameterKey": "KeyPairName",
        "ParameterValue": "<namekeypair>"
      }
      ```

   4. Triển khai lên AWS
      ```
      # Check xem stack đã hợp lệ, đúng hay chưa
      cfn-lint **/*.yml  

      # Upload các stack đã tạo trong folder stack lên S3 Bucket đã tạo ở bước trên
      aws s3 cp ./stack s3://your-bucket-name/ --recursive --exclude "*" --include "*.yml" 

      # Triển khai
      aws cloudformation create-stack \
      --stack-name <nameStack>   \
      --template-body file://templates.yml   \
      --parameters file://parameter.json   \
      --capabilities CAPABILITY_IAM CAPABILITY_AUTO_EXPAND

      # Kiểm tra tình trạng của stack
      aws cloudformation describe-stacks --stack-name <your-stack-name>
      ```
   5. Dọn dẹp tài nguyên
      ```
      aws cloudformation delete-stack --stack-name <your-stack-name>
      ```
<!-- END_TF_DOCS -->