using System;
using System.Collections.Generic;
using System.ComponentModel.DataAnnotations;
using System.ComponentModel.Design;
using System.Text;

namespace Sabio.Models.Requests
{
    public class ResourceUpdateRequest : ResourceAddRequest, IModelIdentifier
    {
        
        public int Id { get; set; }
    }
}
