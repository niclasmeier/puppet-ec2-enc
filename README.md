# Example Puppet ENC
Very simple external node classifier which determines the class by the security group(s) of the node. Also merges the EC2 tags into the parameter section of the classification.

## Installation
To run the script you need these gems:

* [aws-sdk](http://aws.amazon.com/de/sdkforruby/)
* YAML

## Run
Just replace placeholders in

```ruby
ACCESS_KEY_ID     = '<YOUR_ACCESS_KEY>'
SECRET_ACCESS_KEY = '<YOUR_SECRET_ACCESS_KEY>'
EC2_ENDPOINT		  = 'eu-west-1.ec2.amazonaws.com'
```
and set the right EC2 API endpoint. A simple 

```shell
./ec2_enc ip-10-10-10-10.eu-west-1.compute.internal	
```
will do

## Acknowledgment
The implementation was heavily inspired by a [blog post](http://engineering.gowalla.com/2011/10/21/puppet/) on the [Gowalla engineering blog](http://engineering.gowalla.com) by [Kevin Lord](https://github.com/lordkev).

Nice work, helped a lot.

## License
The use and distribution terms for this software are covered by the
Eclipse Public License 1.0 (http://opensource.org/licenses/eclipse-1.0.php)
which can be found in the file epl-v10.html at the root of this distribution.
By using this software in any fashion, you are agreeing to be bound by
the terms of this license.
You must not remove this notice, or any other, from this software.

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the
License for the specific language governing permissions and limitations under
the License.