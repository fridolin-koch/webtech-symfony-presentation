<?php
namespace AppBundle\Entity;

use Doctrine\ORM\Mapping as ORM;
use Symfony\Bridge\Doctrine\Validator\Constraints\UniqueEntity;
use Symfony\Component\Validator\Constraints as Assert;

/**
 * @ORM\Entity
 * @ORM\Table("projects")
 * @UniqueEntity("name")
 * @UniqueEntity("id")
 */
class Project
{
    /**
     * @ORM\Id
     * @ORM\Column(type="string")
     * @Assert\NotBlank
     * @Assert\Regex(
     *  pattern="/^[a-z0-9-_]+$/",
     *  message="The project identifier may only contain alphanumeric characters, dashes and underscores"
     * )
     */
    private $id;

    /**
     * @ORM\OneToMany(targetEntity="Task", mappedBy="project")
     * @ORM\OrderBy({"modifiedDate" = "ASC"})
     */
    private $tasks;
}
